//
//  NewsRequestParameters.swift
//  News App
//
//  Created by Mohamed Khaled Gomaa on 18/12/2023.
//

import Foundation

struct NewsRequestParameters: Encodable {
    let search: String
    let pageSize: Int
    let language: String
    let apiKey: String
}
