//
//  Constant.swift
//  News App
//
//  Created by Mohamed Khaled Gomaa on 17/12/2023.
//

import Foundation

struct Constants {
    //8e58842e74f2453bb5e6e3845b386a81 -> 2
    //58aa2a7586654d32ae3156d87ea58859
    //d090b36e7ffd4f38ad37c0c93942a8d6 -> 3
    //e1908b101a67424c85889ec746b3d130
    static let baseURL = "https://newsapi.org/"
    static let apiKey = "e1908b101a67424c85889ec746b3d130"
    static let genericeError = "Something went wrong, please try again later"
    static let getNews = "v2/everything"
    static let getHeadlines = "v2/top-headlines"

    enum Parameter {
        static let apiKey = "apiKey"
        static let page = "page"
        static let pageSize = "pageSize"
        static let search = "q"
        static let headline = "country"
        static let headline2 = "us"
        static let language = "language"
    }
    
    enum Header {
        static let contentType = "Content-Type"
    }

    enum ContentType {
        static let json = "application/json"
    }
}
