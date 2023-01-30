//
//  EditView.swift
//  IphoneIpadFirebase
//
//  Created by masaki on 2023/01/31.
//

import SwiftUI

struct EditView: View {
    
    @State private var title = ""
    @State private var desc = ""
    var platform : String
    var datos : FirebaseModel
    @StateObject var fbSave = FirebaseViewModel()
    
    @State private var imageData : Data = .init(capacity: 0)
    @State private var showMenu = false
    @State private var imagePicker = false
    @State private var source : UIImagePickerController.SourceType = .camera
    
    @State private var progress = false
    @Environment (\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.yellow.edgesIgnoringSafeArea(.all)
                VStack {
                    NavigationLink(destination: ImagePicker(show: $imagePicker, image: $imageData, source: source), isActive: $imagePicker) {
                        EmptyView()
                    }.navigationBarHidden(true)
                
                    TextField("Title", text: $title)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .onAppear {
                            title = datos.title
                        }
                    TextEditor(text: $desc)
                        .frame(height: 200)
                        .onAppear {
                            desc = datos.desc
                        }
                    
                    // In order to make it work we have to add the permissions below to Info.plist
                    // Privacy - Camera Usage Description
                    // Privacy - Photo Library Usage Description
                    Button(action: {
                        showMenu.toggle()
                    }){
                        Text("Load image")
                            .foregroundColor(.black)
                            .bold()
                            .font(.largeTitle)
                    }.actionSheet(isPresented: $showMenu, content: {
                        ActionSheet(title: Text("Menu"), message: Text("Select an option"), buttons: [
                                .default(Text("Camera"), action: {
                                    source = .camera
                                    imagePicker.toggle()
                                }),
                                .default(Text("Library"), action: {
                                    source = .photoLibrary
                                    imagePicker.toggle()
                                }),
                                .default(Text("Cancel"))
                                                                                                     ])
                    })
                    
                    if imageData.count != 0 {
                        Image(uiImage: UIImage(data: imageData)!)
                            .resizable()
                            .frame(width: 250, height: 250)
                            .cornerRadius(15)
                    }
                    
                    Button(action: {
                        if imageData.isEmpty {
                            fbSave.edit(title: title, desc: desc, platform: platform, id: datos.id) { done in
                                if done {
                                    presentationMode.wrappedValue.dismiss()
                                }
                            }
                        } else {
                            progress = true
                            fbSave.editWithImage(title: title, desc: desc, platform: platform, id: datos.id, index: datos, cover: imageData) { done in
                                if done {
                                    presentationMode.wrappedValue.dismiss()
                                }
                            }
                        }
                    }){
                        Text("Edit")
                            .foregroundColor(.black)
                            .bold()
                            .font(.largeTitle)
                    }
                    if progress {
                        Text ("Wait a moment please...")
                            .foregroundColor(.black)
                        ProgressView()
                    }
                    
                    Spacer()
                }.padding(.all)
            }
        }.navigationViewStyle(StackNavigationViewStyle())
    }
}
