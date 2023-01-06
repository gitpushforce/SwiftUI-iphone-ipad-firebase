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
    
    var body: some View {
        ZStack {
            Color.yellow.edgesIgnoringSafeArea(.all)
            VStack {
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
                Button(action: {
                    
                }){
                    Text("Save")
                        .foregroundColor(.black)
                        .bold()
                        .font(.largeTitle)
                }
                Spacer()
            }.padding(.all)
        }
    }
}
