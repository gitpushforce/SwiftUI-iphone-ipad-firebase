//
//  NavBar.swift
//  IphoneIpadFirebase
//
//  Created by masaki on 2023/01/04.
//

import SwiftUI
import Firebase
struct NavBar: View {
    
    var device = UIDevice.current.userInterfaceIdiom
    @Binding var index : String
    @Binding var menu : Bool
    @EnvironmentObject var loginShow : FirebaseViewModel
    
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
                    ButtonView(index: $index, menu: $menu, title: "Add")
                    Button(action: {
                        try! Auth.auth().signOut()
                        UserDefaults.standard.removeObject(forKey: "session")
                        loginShow.show = false
                    }){
                        Text("Sign out")
                            .font(.title)
                            .frame(width: 200)
                            .foregroundColor(.white)
                            .padding(.horizontal, 10)
                    }.background(
                        Capsule().stroke(.white)
                    )
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
