//
//  HomeUseCase.swift
//  News App
//
//  Created by Mohamed Khaled Gomaa on 18/12/2023.
//

import Foundation
protocol HomeUseCase {
    func fetchData(pageSize: Int, page:Int, search: String) async throws -> NewsModel
}

class HomeUseCaseImple: HomeUseCase {
    
    private let repo: HomeRepoProtocol
    init(repo: HomeRepoProtocol = HomeRepoImple()){
        self.repo = repo
    }
    func fetchData(pageSize: Int, page:Int, search: String) async throws -> NewsModel {
        return try await repo.fetchData(pageSize: pageSize, page: page, search: search)
    }
}
