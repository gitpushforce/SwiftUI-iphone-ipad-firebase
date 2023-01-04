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
    var device = UIDevice.current.userInterfaceIdiom
    @Environment(\.horizontalSizeClass) var width
    
    func getColumns() -> Int {
        // if ipad (portrair and landscape) = 3 columns
        // if iphone (portrait (compact)) = 1 column
        // if iphone (landscape (regular)) = 3 columns   ** iphone 14 plus will have 3 columns but iphone 14 pro won't because the pro size class is compact width and compact height
        // check Decive size classes in  https://developer.apple.com/design/human-interface-guidelines/foundations/layout/
        return (device == .pad) ? 3 : ((device == .phone && width == .regular) ? 3 : 1)
    }
    
    var body: some View {
        ZStack {
            VStack {
                NavBar(index: $index, menu: $menu)
                ZStack {
                    if index == "Playstation" {
                        ScrollView(.vertical, showsIndicators: false) {
                            LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 20), count: getColumns()), spacing: 20) {
                                ForEach(1...9, id:\.self) { _ in
                                    CardView()
                                        .padding(.all)
                                }
                            }
                        }
                    } else if index == "Xbox" {
                        VStack {
                            Color.green
                        }
                    } else {
                        VStack {
                            Color.red
                        }
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

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
