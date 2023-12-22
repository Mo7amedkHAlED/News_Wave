//
//  HeadlineViewModel.swift
//  News App
//
//  Created by Mohamed Khaled Gomaa on 18/12/2023.
//

import Foundation
import Combine

class HeadlineViewModel {
    @Published var headlineData: [Article]?
    @Published var errorMessage: String?
    @Published var isLoading: Bool = false
    var cancellables: Set<AnyCancellable> = []
    let headlineUseCase: HeadlinesUseCase
    
    init(headlineUseCase: HeadlinesUseCase = HeadlinesUseCaseImple()) {
        self.headlineUseCase = headlineUseCase
    }
    
    func viewDidLoad() async throws {
        DispatchQueue.main.async { [weak self] in
            self?.isLoading = true
            //self?.addSubscriber()
        }
        try await fetchHeadlinesData()
    }
    func fetchHeadlinesData(pageSize: Int = 20) async throws {
        Task {
            do {
                let result = try await  headlineUseCase.fetchHeadLines(pageSize: pageSize)
                DispatchQueue.main.async {[weak self] in
                    guard let self = self else {return}
                    self.headlineData = result.articles
                    self.isLoading = false
                }
            } catch {
                DispatchQueue.main.async { [weak self] in
                    guard let self = self else {return}
                    self.errorMessage = error.localizedDescription
                    self.isLoading = false
                }
            }
        }
       
    }
    
}

