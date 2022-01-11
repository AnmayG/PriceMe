//
//  CameraViewControllerRepresentable.swift
//  Pods
//
//  Created by Anmay Gupta on 12/15/21.
//

import Foundation
import SwiftUI

struct CameraViewControllerRepresentable: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> CameraViewController {
        let picker = CameraViewController()
        return picker
    }

    func updateUIViewController(_ uiViewController: CameraViewController, context: Context) {
        
    }
}
