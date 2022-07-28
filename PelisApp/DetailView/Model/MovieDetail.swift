//
//  MovieDetail.swift
//  PelisApp
//
//  Created by sebastian abarzua on 17-07-22.
//

import Foundation

struct MovieDetail: Codable {
    let posterPath: String
    let adult: Bool
    let overview: String
    let releaseDate: String
    let id: Int32
    let originalTitle: String
    let originalLanguage: String
    let title: String
    let backdropPath: String
    let popularity: Double
    let voteCount: Int
    let video: Bool
    let voteAverage: Double
    
    enum CodingKeys: String, CodingKey{
        case posterPath = "poster_path"
        case adult
        case overview
        case releaseDate = "release_date"
        case id
        case originalTitle = "original_title"
        case originalLanguage = "original_language"
        case title
        case backdropPath = "backdrop_path"
        case popularity
        case voteCount = "vote_count"
        case video
        case voteAverage = "vote_average"
    }
}
