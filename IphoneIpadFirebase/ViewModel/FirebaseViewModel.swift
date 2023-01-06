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
    
    func createUser(email: String, pass: String, completion: @escaping(_ done: Bool) -> Void) {
        Auth.auth().createUser(withEmail: email, password: pass) { (user, error) in
            if user != nil {
                print ("user registered and logged in")
                completion(true)
            } else {
                if let error = error?.localizedDescription {
                    print("Error in Firebase while trying to register user")
                } else {
                    print ("Error in App while trying to register user")
                }
            }
        }
    }
    
    // DATABASE
    
    // SAVE
    func save(title: String, desc: String, platform: String, cover: String, completion: @escaping (_ done: Bool) -> Void) {
        let db = Firestore.firestore()
        let id = UUID().uuidString
        guard let idUser = Auth.auth().currentUser?.uid else { return }
        guard let email = Auth.auth().currentUser?.email else { return }
        
        let fields : [String:Any] = ["title": title, "desc": desc, "cover": cover, "idUser": idUser, "email": email]
        db.collection(platform).document(id).setData(fields) {error in
            if let error = error?.localizedDescription {
                print("error while trying to save in Firestore", error)
            } else {
                print("saved correctly")
                completion(true)
            }
        }
    }
    
}
