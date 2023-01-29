//
//  CardView.swift
//  IphoneIpadFirebase
//
//  Created by masaki on 2023/01/04.
//

import SwiftUI

struct CardView: View {
    
    var title : String
    var cover : String
    
    var body: some View {
        VStack (spacing: 20) {
            ImageFirebase(imageUrl: cover)
            Text(title)
                .font(.title)
                .bold()
                .foregroundColor(.black)
        }.padding()
        .background(.white)
        .cornerRadius(20)
    }
}
