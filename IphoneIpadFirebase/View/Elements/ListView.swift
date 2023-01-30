//
//  ListView.swift
//  IphoneIpadFirebase
//
//  Created by masaki on 2023/01/29.
//

import SwiftUI

struct ListView: View {
    
    var device = UIDevice.current.userInterfaceIdiom
    @Environment(\.horizontalSizeClass) var width
    
    func getColumns() -> Int {
        // if ipad (portrair and landscape) = 3 columns
        // if iphone (portrait (compact)) = 1 column
        // if iphone (landscape (regular)) = 3 columns   ** iphone 14 plus will have 3 columns but iphone 14 pro won't because the pro size class is compact width and compact height
        // check Decive size classes in  https://developer.apple.com/design/human-interface-guidelines/foundations/layout/
        return (device == .pad) ? 3 : ((device == .phone && width == .regular) ? 3 : 1)
    }
    
    var platform : String
    @StateObject var datos = FirebaseViewModel()
    @State private var showEdit = false
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 20), count: getColumns()), spacing: 20) {
                ForEach(datos.data) { item in
                    CardView(title: item.title, cover: item.cover, index: item, platform: platform)
                        .onTapGesture {
                            showEdit.toggle()
                        }.sheet(isPresented: $showEdit, content: {
                            EditView(platform: platform, datos: item)
                        })
                        .padding(.all)
                }
            }
        }.onAppear {
            datos.getData(platform: platform)
        }
    }
}
