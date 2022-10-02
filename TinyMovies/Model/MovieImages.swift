//
//  MovieImages.swift
//  TinyMovies
//
//  Created by Hussein Elbeheiry on 10/1/22.
//

import Foundation

struct MovieImages: Codable {
    let backdrops: [ImageData]?
}

struct ImageData: Codable, Identifiable {
    let id: UUID
    let aspect_ratio: Float
    let file_path: URL
    let height: Int
    let width: Int
}
