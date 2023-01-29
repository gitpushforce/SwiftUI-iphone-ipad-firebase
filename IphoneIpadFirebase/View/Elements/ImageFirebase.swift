//
//  ImageFirebase.swift
//  IphoneIpadFirebase
//
//  Created by masaki on 2023/01/29.
//

import SwiftUI

struct ImageFirebase: View {
    
    let alternativeImage = UIImage(systemName: "photo")
    @ObservedObject var imageLoader : PortadaViewModel
    
    init(imageUrl: String) {
        imageLoader = PortadaViewModel(imageUrl: imageUrl)
    }
    
    var image : UIImage? {
        imageLoader.data.flatMap(UIImage.init)
    }
    
    var body: some View {
        Image(uiImage: image ?? alternativeImage!)
            .resizable()
            .cornerRadius(20)
            .shadow(radius: 5)
            .aspectRatio(contentMode: .fit)
        
    }
}
