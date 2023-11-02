//
//  ProfileSecondView.swift
//  WeatherToday
//
//  Created by Viktor on 2023-11-01.
//

import SwiftUI
import UIKit
import PhotosUI


struct UserProfileView: View {
    @State private var avatarImage: UIImage?
    @State private var photosPickerItem: PhotosPickerItem?
    
    init() {
           if let imageData = UserDefaults.standard.data(forKey: "profilePicture"),
              let savedImage = UIImage(data: imageData) {
               self._avatarImage = State(initialValue: savedImage)
           }
       }
    
    var body: some View {
        VStack {
            HStack(spacing: 20) {
                PhotosPicker(selection: $photosPickerItem, matching: .images) {
                    Image(uiImage: (avatarImage ?? UIImage(systemName: "person.circle.fill"))!)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 100, height: 100)
                        .clipShape(.circle)
                }
                
                VStack(alignment: .leading) {
                    Text("Viktor Burenin")
                        .font(.title)
                    
                    Text("iOS Developer")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
                Spacer()
            }
            Spacer()
            }
            .padding(30)
            .onChange(of: photosPickerItem) { _, _ in
                Task {
                    if let photosPickerItem,
                       let data = try? await photosPickerItem.loadTransferable(type: Data.self) {
                        if let image = UIImage(data:data) {
                            avatarImage = image
                            
                            if let imageData = image.pngData() {
                                                       UserDefaults.standard.set(imageData, forKey: "profilePicture")
                                                   }
                        }
                    }
                    photosPickerItem = nil
            }
        }
    }
}

#Preview {
    UserProfileView()
}
