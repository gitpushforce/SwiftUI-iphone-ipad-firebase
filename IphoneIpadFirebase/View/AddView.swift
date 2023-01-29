//
//  AddView.swift
//  IphoneIpadFirebase
//
//  Created by masaki on 2023/01/06.
//

import SwiftUI

struct AddView: View {
    
    @State private var title = ""
    @State private var desc = ""
    var consoles = ["playstation", "xbox", "switch"]
    @State private var platform = "playstation"
    @StateObject var fbSave = FirebaseViewModel()
    
    @State private var imageData : Data = .init(capacity: 0)
    @State private var showMenu = false
    @State private var imagePicker = false
    @State private var source : UIImagePickerController.SourceType = .camera
    
    @State private var progress = false
    
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
                    TextEditor(text: $desc)
                        .frame(height: 200)
                    Picker("Consoles", selection: $platform) {
                        ForEach(consoles, id:\.self) { item in
                            Text(item)
                                .foregroundColor(.black)
                        }
                    }.pickerStyle(.wheel)
                    
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
                        
                        Button(action: {
                            progress = true
                            fbSave.save(title: title, desc: desc, platform: platform, cover: imageData) { (done) in
                                if done {
                                    title = ""
                                    desc = ""
                                    // this is to clean the image
                                    imageData = .init(Data(capacity: 0))
                                    progress = false
                                }
                            }
                        }){
                            Text("Save")
                                .foregroundColor(.black)
                                .bold()
                                .font(.largeTitle)
                        }
                        if progress {
                            Text ("Wait a moment please...")
                                .foregroundColor(.black)
                            ProgressView()
                        }
                    }
                    
                    Spacer()
                }.padding(.all)
            }
        }.navigationViewStyle(StackNavigationViewStyle())
    }
}
