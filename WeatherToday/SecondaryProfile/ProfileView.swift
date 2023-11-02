//
//  ProfileView.swift
//  WeatherToday
//
//  Created by Viktor on 2023-11-01.
//

import SwiftUI

struct ProfileView: View {
    @State private var selectedImage: UIImage?
    @State private var isImagePickerPresented: Bool = false
    // ... other properties and methods
    
    func showImagePicker() {
        isImagePickerPresented = true
    }

    var body: some View {
        
        ZStack {
            
            
            
            HStack {
                if let image = selectedImage {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFit()
                        .clipShape(Circle())
                        .frame(width: 100, height: 100)
                        .padding()
                } else {
                    Image(systemName: "person.circle")
                        .resizable()
                        .scaledToFit()
                        .clipShape(Circle())
                        .frame(width: 100, height: 100)
                        .padding()
                }
                
                
                Button(action: {
                    showImagePicker()
                }) {
                    Text("Pick Profile Picture")
                }
                .sheet(isPresented: $isImagePickerPresented) {
                    ImagePicker(selectedImage: $selectedImage, isPresented: $isImagePickerPresented)
                }
            }
            .padding()
        }
    }

    // ... other methods
}

#Preview {
    ProfileView()
}
