//
//  HeadlineViewModel.swift
//  News App
//
//  Created by Mohamed Khaled Gomaa on 18/12/2023.
//

import Foundation
import Combine

class HeadlineViewModel: ObservableObject {
    @Published var headlineData: [Article]?
    @Published var errorMessage: String?
    @Published var isLoading: Bool = false
    private var pagesize: Int = 10
    private var page: Int = 1
    var cancellables: Set<AnyCancellable> = []
    let headlineUseCase: HeadlinesUseCase
    
    init(headlineUseCase: HeadlinesUseCase = HeadlinesUseCaseImple()) {
        self.headlineUseCase = headlineUseCase
        viewDidLoad(pageSize: pagesize)
    }
    
    func viewDidLoad(pageSize: Int) {
        isLoading = true
        fetchHeadlinesData(pageSize: pageSize)
    }
    
    func loadNextPage() {
        pagesize += 10
        fetchHeadlinesData(pageSize: pagesize)
    }
    
    func fetchHeadlinesData(pageSize: Int) {
        Task {
            do {
                let result = try await  headlineUseCase.fetchHeadLines(pageSize: pageSize, page: page)
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

