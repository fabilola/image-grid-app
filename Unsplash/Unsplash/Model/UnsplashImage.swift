//
//  UnsplashImage.swift
//  Unsplash
//
//  Created by Fabiola Dums on 19.03.23.
//

import Foundation

// MARK: - UnsplashImage
struct UnsplashImage: Codable {
    let total, totalPages: Int
    let results: [UnsplashImageElement]

    enum CodingKeys: String, CodingKey {
        case total
        case totalPages = "total_pages"
        case results
    }
}

// MARK: - Result
struct UnsplashImageElement: Codable {
    let id, color: String
    let blurHash: String?
    let urls: Urls
    let links: Links
    let user: User

    enum CodingKeys: String, CodingKey {
        case id, color
        case blurHash = "blur_hash"
        case urls, links, user
    }
}

// MARK: - Links
struct Links: Codable {
    let linksSelf, html, download, downloadLocation: String

    enum CodingKeys: String, CodingKey {
        case linksSelf = "self"
        case html, download
        case downloadLocation = "download_location"
    }
}

// MARK: - Urls
struct Urls: Codable {
    let raw, full, regular, small: String
    let thumb, smallS3: String

    enum CodingKeys: String, CodingKey {
        case raw, full, regular, small, thumb
        case smallS3 = "small_s3"
    }
}

// MARK: - User
struct User: Codable {
    let id, name: String
}
