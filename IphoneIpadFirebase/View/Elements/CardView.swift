//
//  CardView.swift
//  IphoneIpadFirebase
//
//  Created by masaki on 2023/01/04.
//

import SwiftUI

struct CardView: View {
    var body: some View {
        VStack (spacing: 20) {
            Image("syphonfilter")
                .resizable()
                .aspectRatio(contentMode: .fit)
            Text("Syphon Filter")
                .font(.title)
                .bold()
                .foregroundColor(.black)
        }.padding()
        .background(.white)
        .cornerRadius(20)
    }
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView()
    }
}
