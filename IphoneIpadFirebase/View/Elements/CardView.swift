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
    
    var index : FirebaseModel
    var platform : String
    
    @StateObject var data = FirebaseViewModel()
    
    var body: some View {
        VStack (spacing: 20) {
            ImageFirebase(imageUrl: cover)
            Text(title)
                .font(.title)
                .bold()
                .foregroundColor(.black)
            
            Button(action: {
                data.delete(index: index, plataform: platform)
            }){
                Text("Delete")
                    .foregroundColor(.red)
                    .padding(.vertical, 10)
                    .padding(.horizontal, 25)
                    .background(Capsule().stroke(Color.red))
            }
            
        }.padding()
        .background(.white)
        .cornerRadius(20)
    }
}
