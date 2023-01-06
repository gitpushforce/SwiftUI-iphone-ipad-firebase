//
//  ContentView.swift
//  IphoneIpadFirebase
//
//  Created by masaki on 2023/01/04.
//

import SwiftUI

struct ContentView: View {
    
    @EnvironmentObject var loginShow : FirebaseViewModel
    
    var body: some View {
        
        return Group {
            if loginShow.show {
                Home()
                    .edgesIgnoringSafeArea(.all)
                    .preferredColorScheme(.dark)
            } else {
                Login()
            }
        }.onAppear {
            if (UserDefaults.standard.object(forKey: "session")) != nil {
                loginShow.show = true
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
