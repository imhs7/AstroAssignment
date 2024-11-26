//
//  DataModel.swift
//  testAstro
//
//  Created by Hemant on 26/11/24.
//

import Foundation

struct MovieData: Decodable {
    var Title: String?
    var Year: String?
    var imdbID: String?
    var movieType: String?
    var Poster: String?
    
    enum CodingKeys: String, CodingKey {
        case Title = "Title"
        case Year = "Year"
        case imdbID = "imdbID"
        case movieType = "Type"
        case Poster = "Poster"
    }
}

struct MovieResponse: Decodable {
    let search: [MovieData]
    
    enum CodingKeys: String, CodingKey {
        case search = "Search"
    }
}

