//
//  UnsplashApp.swift
//  Unsplash
//
//  Created by Fabiola Dums on 18.03.23.
//

import SwiftUI

@main
struct UnsplashApp: App {
    @StateObject private var modelData = ModelData()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(modelData)
        }
    }
}
