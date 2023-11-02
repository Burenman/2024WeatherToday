//
//  ImagePicker.swift
//  WeatherToday
//
//  Created by Viktor on 2023-11-01.
//

import Foundation
import SwiftUI
import UIKit


class UIImagePickerCoordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    @Binding var selectedImage: UIImage?

    init(selectedImage: Binding<UIImage?>) {
        _selectedImage = selectedImage
    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let uiImage = info[.originalImage] as? UIImage {
            selectedImage = uiImage
        }
        picker.dismiss(animated: true)
    }

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true)
    }
}


struct ImagePicker: UIViewControllerRepresentable {
    @Binding var selectedImage: UIImage?
    @Binding var isPresented: Bool

    func makeCoordinator() -> UIImagePickerCoordinator {
        return UIImagePickerCoordinator(selectedImage: $selectedImage)
    }

    func makeUIViewController(context: Context) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator
        return picker
    }

    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {
        if isPresented {
            uiViewController.sourceType = .photoLibrary // You can change this to .camera for camera access
        }
    }
}

