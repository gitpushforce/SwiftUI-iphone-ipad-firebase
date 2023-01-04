//
//  NavBar.swift
//  IphoneIpadFirebase
//
//  Created by masaki on 2023/01/04.
//

import SwiftUI

struct NavBar: View {
    
    var device = UIDevice.current.userInterfaceIdiom
    @Binding var index : String
    @Binding var menu : Bool
    
    var body: some View {
        HStack {
            Text("My game")
                .font(.title)
                .bold()
                .foregroundColor(.white)
                .font(.system(size: device == .phone ? 25 : 35))
            Spacer()
            if device == .pad {
                // menu ipad
                HStack(spacing: 25) {
                    ButtonView(index: $index, menu: $menu, title: "Playstation")
                    ButtonView(index: $index, menu: $menu, title: "Xbox")
                    ButtonView(index: $index, menu: $menu, title: "Switch")
                }
            } else {
                // menu iphone
                Button(action: {
                    withAnimation {
                        menu.toggle()
                    }
                }){
                    Image(systemName: "line.horizontal.3")
                        .font(.system(size: 26))
                        .foregroundColor(.white)
                }
            }
        }
        .padding(.top, 30)
        .padding()
        .background(.purple)
    }
}
