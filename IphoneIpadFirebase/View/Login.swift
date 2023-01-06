//
//  Login.swift
//  IphoneIpadFirebase
//
//  Created by masaki on 2023/01/06.
//

import SwiftUI

struct Login: View {
    
    @State private var email = ""
    @State private var pass = ""
    @StateObject var login = FirebaseViewModel()
    @EnvironmentObject var loginShow : FirebaseViewModel
    var device = UIDevice.current.userInterfaceIdiom
    
    var body: some View {
        ZStack {
            Color.purple.edgesIgnoringSafeArea(.all)
            VStack {
                Text ("My Games")
                    .font(.largeTitle)
                    .foregroundColor(.white)
                    .bold()
                TextField("Email", text: $email)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .keyboardType(.emailAddress)
                    .disableAutocorrection(true)
                    .autocapitalization(.none)
                    .frame(width: device == .pad ? 400 : nil)
                SecureField("Pass", text: $pass)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .frame(width: device == .pad ? 400 : nil)
                    .padding(.bottom, 20)
                
                Button(action: {
                    login.login(email: email, pass: pass) { (done) in
                        if done {
                            // to save session in UserDefaults.
                            UserDefaults.standard.set(true, forKey: "session")
                            loginShow.show.toggle()
                        }
                    }
                }){
                    Text("Login")
                        .font(.title)
                        .frame(width: 200)
                        .foregroundColor(.white)
                        .padding(.vertical, 10)
                }.background(
                    // to make the border of the button look like a rounded white circle we use Capsule and stroke white
                    Capsule()
                        .stroke(.white)
                )
                
                Divider()
                
                Button(action: {
                    login.createUser(email: email, pass: pass) { (done) in
                        if done {
                            // to save session in UserDefaults.
                            UserDefaults.standard.set(true, forKey: "session")
                            loginShow.show.toggle()
                        }
                    }
                }){
                    Text("Sign up")
                        .font(.title)
                        .frame(width: 200)
                        .foregroundColor(.white)
                        .padding(.vertical, 10)
                }.background(
                    // to make the border of the button look like a rounded white circle we use Capsule and stroke white
                    Capsule()
                        .stroke(.white)
                )
            }.padding(.all)
        }
    }
}

struct Login_Previews: PreviewProvider {
    static var previews: some View {
        Login()
    }
}
