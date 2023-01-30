//
//  FirebaseViewModel.swift
//  IphoneIpadFirebase
//
//  Created by masaki on 2023/01/06.
//

import Foundation
import Firebase
import FirebaseStorage

class FirebaseViewModel : ObservableObject {
    
    @Published var show = false
    @Published var data = [FirebaseModel]()
    
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
    func save(title: String, desc: String, platform: String, cover: Data, completion: @escaping (_ done: Bool) -> Void) {
        
        let storage = Storage.storage().reference()
        let nameCover = UUID()
        let directory = storage.child("images/\(nameCover)")
        let metadata = StorageMetadata()
        metadata.contentType = "image/png"
        
        directory.putData(cover, metadata: metadata) { data, error in
            if error == nil {
                print("image saved")
                
                // save text
                let db = Firestore.firestore()
                let id = UUID().uuidString
                guard let idUser = Auth.auth().currentUser?.uid else { return }
                guard let email = Auth.auth().currentUser?.email else { return }
                
                let fields : [String:Any] = ["title": title, "desc": desc, "cover": String(describing: directory), "idUser": idUser, "email": email]
                db.collection(platform).document(id).setData(fields) {error in
                    if let error = error?.localizedDescription {
                        print("error while trying to save in Firestore", error)
                    } else {
                        print("saved correctly")
                        completion(true)
                    }
                }
                // finished saving text
                
            } else {
                if let error = error?.localizedDescription {
                    print("failed trying to upload image", error)
                } else {
                    print("fail in app")
                }
            }
        }
    }
    
    func getData(platform: String) {
        let db = Firestore.firestore()
        db.collection(platform).addSnapshotListener { (querySnapshot, error) in
            if let error = error?.localizedDescription {
                print("error while trying to get data", error)
            } else {
                self.data.removeAll()
                for document in querySnapshot!.documents {
                    let value = document.data()
                    let id = document.documentID
                    let title = value["title"] as? String ?? "no title"
                    let desc = value["desc"] as? String ?? "no desc"
                    let cover = value["cover"] as? String ?? "no cover"
                    
                    DispatchQueue.main.async {
                        let regist = FirebaseModel(id: id, title: title, desc: desc, cover: cover)
                        self.data.append(regist)
                    }
                }
            }
        }
    }
    
    // ELIMINAR
    func delete(index: FirebaseModel, plataform: String) {
        // eliminar firestore
        let id = index.id
        let db = Firestore.firestore()
        db.collection(plataform).document(id).delete()
        
        // eliminar storage
        let image = index.cover
        let deleteImage = Storage.storage().reference(forURL: image)
        deleteImage.delete(completion: nil)
        
    }
    
    // EDITAR
    func edit (title: String, desc: String, platform: String, id: String, completion: @escaping (_ done: Bool) -> Void ) {
        let db = Firestore.firestore()
        let fields : [String:Any] = ["title": title, "desc": desc]
        db.collection(platform).document(id).updateData(fields) { error in
            if let  error = error?.localizedDescription {
                print ("error while editing", error)
                
            } else {
                print("only text edited")
                completion(true)
            }
        }
    }
    
    // EDIT WITH IMAGE
    func editWithImage (title: String, desc: String, platform: String, id: String, index: FirebaseModel, cover: Data, completion: @escaping (_ done: Bool) -> Void ) {
        // ELIMINAR LA IMAGEN
        let image = index.cover
        let deleteImage = Storage.storage().reference(forURL: image)
        deleteImage.delete(completion: nil)
        
        // UPLOAD NEW IMAGE
        let storage = Storage.storage().reference()
        let nameCover = UUID()
        let directory = storage.child("images/\(nameCover)")
        let metadata = StorageMetadata()
        metadata.contentType = "image/png"
        
        directory.putData(cover, metadata: metadata) { data, error in
            if error == nil {
                print("new image saved")
                
                // editing text
                let db = Firestore.firestore()
                let fields : [String:Any] = ["title": title, "desc": desc, "cover": String(describing: directory)]
                db.collection(platform).document(id).updateData(fields) { error in
                    if let  error = error?.localizedDescription {
                        print ("error while editing", error)
                        
                    } else {
                        print("only text edited")
                        completion(true)
                    }
                }
                // finished editing text
                
            } else {
                if let error = error?.localizedDescription {
                    print("failed trying to upload image", error)
                } else {
                    print("fail in app")
                }
            }
        }
    }
    
}
