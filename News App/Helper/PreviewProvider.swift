//
//  PreviewProvider.swift
//  News App
//
//  Created by Mohamed Khaled Gomaa on 18/12/2023.
//

import Foundation
import SwiftUI

extension PreviewProvider {
    
    static var dev: DeveloperPreview {
        return DeveloperPreview.instance
    }
    
}

class DeveloperPreview {
    static let instance = DeveloperPreview()
    let homeVM = HomeViewModel()
    
    private init() { }
    let news = NewsModel(status: "ok", totalResults: 93180, articles: [
        Article(
            source: Source(id: "1", name: "Gizmodo.com"),
            author: "James Whitbrook",
            title: "The Marvels Drama, Fallout TV Show Reveals, and More Top Pop Culture News of the Week",
            description: "It’s been a wild week in the world of sci-fi, fantasy, superheroes, and more genre fare. The return of Doctor Who for its 60th anniversary, burning Mandalorian questions, and our epic first looks at Fallout and Furiosa all made the list of our most read stori…",
            url: "https://gizmodo.com/top-entertainment-news-fallout-doctor-who-marvel-alien-1851065738",
            urlToImage: "https://i.kinja-img.com/image/upload/c_fill,h_675,pg_1,q_80,w_1200/7ad4a85d6aa22e76d0ba5d6e534a2e59.jpg",
            publishedAt: "2023-12-02T15:00:00Z",
            content: "Its been a wild week in the world of sci-fi, fantasy, superheroes, and more genre fare. The return of Doctor Who for its 60th anniversary, burning Mandalorian questions, and our epic first looks at F… [+3679 chars]"
        )
    ]
    )
}
