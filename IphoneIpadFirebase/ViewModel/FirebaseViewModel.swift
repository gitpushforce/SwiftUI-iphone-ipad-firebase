//
//  FirebaseViewModel.swift
//  IphoneIpadFirebase
//
//  Created by masaki on 2023/01/06.
//

import Foundation
import Firebase

class FirebaseViewModel : ObservableObject {
    
    @Published var show = false
    
    func login(email: String, pass: String, completion: @escaping(_ done: Bool) -> Void) {
        Auth.auth().signIn(withEmail: email, password: pass) { (user, error) in
            if user != nil {
                print ("logged in")
                completion(true)
            } else {
                if let error = error?.localizedDescription {
                    print("Error in Firebase")
                } else {
                    print ("Error in App")
                }
            }
        }
    }
}
