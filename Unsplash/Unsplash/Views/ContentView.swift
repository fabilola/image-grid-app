//
//  ContentView.swift
//  Unsplash
//
//  Created by Fabiola Dums on 18.03.23.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var data: ModelData
    @State private var searchText: String  = ""
    
    var body: some View {
        NavigationStack {
            VStack{
                ScrollView {
                    if !data.images.isEmpty {
                        LazyVGrid(columns: [GridItem](repeating: GridItem(.flexible(), spacing: 20), count: 2), spacing: 20) {
                            ForEach(data.images, id: \.id) { image in
                                GridImage(imageUrl: image.urls.small, imageBlur: image.blurHash)
                                    .frame(maxWidth: .infinity)
                                    .contextMenu(menuItems: {
                                        Label(image.user.name, systemImage:"person.circle")
                                    })
                            }
                        }
                        .padding()
                        
                        Button("Clear Search", action: {
                            data.clearImages()
                        })
                    }
                    else {
                        
                        Text("Enter keyword to search for images from Unsplash")
                            .foregroundColor(.secondary)
                            .frame(maxWidth: .infinity, alignment: .center)
                            .multilineTextAlignment(.center)
                            .padding()
                    }
                }
            }
            .navigationTitle("Unsplash Image Grid")
        }
        .searchable(text: $searchText)
        .onSubmit(of: .search) {
            data.getImages(searchKeyword: searchText)
        }
        .alert(data.alertTitle, isPresented: $data.showAlert, actions : {
            Button("OK", role: .cancel) {}
        }, message : {
            Text(data.alertText)
        })
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(ModelData())
    }
}
