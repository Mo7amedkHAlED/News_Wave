//
//  HeadlinesUseCase.swift
//  News App
//
//  Created by Mohamed Khaled Gomaa on 18/12/2023.
//

import Foundation

protocol HeadlinesUseCase {
    func fetchHeadLines(pageSize: Int, page: Int) async throws -> NewsModel
}

class HeadlinesUseCaseImple: HeadlinesUseCase {
    private let repo: HeadlLineRepoProtocol
    init(repo: HeadlLineRepoProtocol = HeadlineRepoImple() ) {
        self.repo = repo
    }
    
    func fetchHeadLines(pageSize: Int, page: Int) async throws -> NewsModel {
        return try await repo.fetchHeadlines(pageSize: pageSize, page: page)
    }
    
}
