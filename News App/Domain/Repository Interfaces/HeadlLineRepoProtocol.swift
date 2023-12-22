//
//  HeadlLineRepoProtocol.swift
//  News App
//
//  Created by Mohamed Khaled Gomaa on 18/12/2023.
//

import Foundation

protocol HeadlLineRepoProtocol {
    func fetchHeadlines(pageSize: Int, page: Int) async throws -> NewsModel
}
