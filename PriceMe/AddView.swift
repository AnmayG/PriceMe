//
//  AddView.swift
//  PriceMe
//
//  Created by Anmay Gupta on 12/12/21.
//

import Foundation
import SwiftUI
import CoreData

struct AddView: View {
    
    @State var backgroundDialColor = Color.green
    @State var foregroundDialColor = Color.white
    
    var body: some View {
        VStack {
            ZStack {
                Circle()
                    .fill(backgroundDialColor)
                    .opacity(0.7)
                    .frame(width: 310,
                           height: 310,
                           alignment: .center)
                DialView(temperature: 0)
            }
        }
    }
}

struct DialView: View {
    @State private var value: CGFloat = 0
    @State private var finalValue: CGFloat = 0
    @State private var valueString: String = ""

    private let initialTemperature: CGFloat
    private let scale: CGFloat = 275
    private let indicatorLength: CGFloat = 25
    private let maxTemperature: CGFloat = 32
    private let stepSize: CGFloat = 0.5

    private var innerScale: CGFloat {
        return scale - indicatorLength
    }
    
    init(temperature: CGFloat) {
        self.initialTemperature = temperature
    }

    private func angle(between starting: CGPoint, ending: CGPoint) -> CGFloat {
        let center = CGPoint(x: ending.x - starting.x, y: ending.y - starting.y)
        let radians = atan2(center.y, center.x)
        var degrees = 90 + (radians * 180 / .pi)

        if degrees < 0 {
            degrees += 360
        }

        return degrees
    }

    var body: some View {
        ZStack(alignment: .center) {
            Circle()
                .fill(Color.white)
                .frame(width: self.innerScale, height: self.innerScale, alignment: .center)
                .rotationEffect(.degrees(-90))
                .gesture(
                    DragGesture().onChanged() { value in

                        let x: CGFloat = min(max(value.location.x, 0), self.innerScale)
                        let y: CGFloat = min(max(value.location.y, 0), self.innerScale)

                        let ending = CGPoint(x: x, y: y)
                        let start = CGPoint(x: (self.innerScale) / 2, y: (self.innerScale) / 2)

                        let angle = self.angle(between: start, ending: ending)
                        self.value = CGFloat(Int(((angle / 360) * (self.maxTemperature / self.stepSize)))) / (self.maxTemperature / self.stepSize)
                        self.finalValue = self.value * self.maxTemperature
                        self.valueString = String(format: "%.2f", self.finalValue)
                    }
                )
            Circle()
                .stroke(Color.gray, style: StrokeStyle(lineWidth: self.indicatorLength, lineCap: .butt, lineJoin: .miter, dash: [4]))
                .frame(width: self.scale, height: self.scale, alignment: .center)
            Circle()
                .trim(from: 0.0, to: self.value)
                .stroke(Color.black, style: StrokeStyle(lineWidth: self.indicatorLength, lineCap: .butt, lineJoin: .miter, dash: [4]))
                .rotationEffect(.degrees(-90))
                .frame(width: self.scale, height: self.scale, alignment: .center)
            HStack {
                Spacer()
                Text("$")
                    .font(.largeTitle)
                    .foregroundColor(Color.black)
                    .fontWeight(.semibold)
                TextField("0.00", text: $valueString)
                    .font(.largeTitle)
                    .foregroundColor(Color.black)
                    .frame(width: 100, alignment: .center)
                    .onTapGesture {
                        print("The text field was pressed!")
                    }
                Spacer()
            }
        }
        .onAppear(perform: {
            self.value = self.initialTemperature / self.maxTemperature
        })
    }
}
