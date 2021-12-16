//
//  ContentView.swift
//  PriceMe
//
//  Created by Anmay Gupta on 12/10/21.
//

import SwiftUI
import CoreData

struct ContentView: View {
    var body: some View {
        TabView{
            MainView()
            .tabItem {
                Label("Home", systemImage: "house.fill")
            }
            
            AddView()
            .tabItem {
                Label("Add", systemImage: "plus")
            }
           
            CameraView()
            .tabItem {
                Label("Camera", systemImage: "camera")
            }
           
            Text("Settings")
            .tabItem{
                Label("Settings", systemImage:"gear")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
