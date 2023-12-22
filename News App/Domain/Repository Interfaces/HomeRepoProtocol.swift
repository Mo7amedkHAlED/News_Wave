//
//  HomeRepoProtocol.swift
//  News App
//
//  Created by Mohamed Khaled Gomaa on 18/12/2023.
//

import Foundation

protocol HomeRepoProtocol {
    func fetchData(pageSize: Int, page: Int, search: String) async throws -> NewsModel
}
