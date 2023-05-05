//
//  GridImage.swift
//  Unsplash
//
//  Created by Fabiola Dums on 19.03.23.
//

import SwiftUI

struct GridImage: View {
    var imageUrl: String
    var imageBlur: String?
    
    var body: some View {
        AsyncImage(url: URL(string:  imageUrl)) { image in
            image
                .resizable()
                .scaledToFill()
                .frame(width: (UIScreen.main.bounds.width/2) - 20)
                .clipped()
                .cornerRadius(4)
        }
    placeholder: {
        BlurredPlacerholder(blurHash: imageBlur)
        }
    }
    
}

struct GridImage_Previews: PreviewProvider {
    static var previews: some View {
        GridImage(imageUrl: "", imageBlur: "")
    }
}
