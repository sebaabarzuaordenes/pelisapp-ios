//
//  Constans.swift
//  PelisApp
//
//  Created by sebastian abarzua on 15-07-22.
//

import Foundation

struct Constans{
    static let apyKey = "?api_key=40f6ad3e20557ee7f1830eeb81036d11"
    
    struct URL {
        static let main = "https://api.themoviedb.org/"
        static let urlImage = "https://image.tmdb.org/t/p/w200"
    }
    
    struct EndPoint{
        static let urlPopularListMovies = "3/movie/popular"
        static let urlDetailMovie = "3/movie/"
    }
}
