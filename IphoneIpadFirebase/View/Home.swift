//
//  Home.swift
//  IphoneIpadFirebase
//
//  Created by masaki on 2023/01/04.
//

import SwiftUI

struct Home: View {
    
    @State private var index = "Playstation"
    @State private var menu = false
    @State private var widthMenu = UIScreen.main.bounds.width
    
    var body: some View {
        ZStack {
            VStack {
                NavBar(index: $index, menu: $menu)
                ZStack {
                    if index == "Playstation" {
                        
                    } else if index == "Xbox" {
                        VStack {
                            Color.green
                        }
                    } else if index == "Switch" {
                        VStack {
                            Color.red
                        }
                    } else {
                        AddView()
                    }
                }
            }
            // ----- ipad navbar end -----
            
            // ----- iphone navbar start ----
            if menu {
                HStack {
                    Spacer()
                    VStack {
                        HStack {
                            Spacer()
                            Button(action: {
                                withAnimation {
                                    menu.toggle()
                                }
                            }){
                                Image(systemName: "xmark")
                                    .font(.system(size: 22, weight: .bold))
                                    .foregroundColor(.white)
                            }
                        }.padding()
                        .padding(.top, 50)
                        VStack(alignment: .trailing) {
                            ButtonView(index: $index, menu: $menu, title: "Playstation")
                            ButtonView(index: $index, menu: $menu, title: "Xbox")
                            ButtonView(index: $index, menu: $menu, title: "Switch")
                        }
                        Spacer()
                    }
                    .frame(width: widthMenu - 200)
                    .background(Color.purple)
                }
            }
        }.background(.white.opacity(0.9))
    }
}
