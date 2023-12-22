//
//  HomeViewModel.swift
//  News App
//
//  Created by Mohamed Khaled Gomaa on 16/12/2023.
//

import Foundation
import Combine

class HomeViewModel: ObservableObject {
    @Published var searchText: String = ""
    @Published var newsInfo: [Article]?
    @Published var filterData: [Article]?
    @Published var errorMessage: String?
    @Published var isLoading: Bool = false
    private var pageSize: Int = 5
    private var page: Int = 1
    var cancellables: Set<AnyCancellable> = []
    private let homeUseCase: HomeUseCase
    init(homeUseCase: HomeUseCase = HomeUseCaseImple()) {
        self.homeUseCase = homeUseCase
         viewDidLoad()
    }
    
    func viewDidLoad() {
        isLoading = true
        searchINServer()
        fetchNews(pageSize: pageSize)
    }
    
    func loadNextPage() {
        pageSize += 10
        fetchNews(pageSize: pageSize)
    }
    
    func addSubscriber() {
        // search local (offline)
        $searchText.combineLatest($filterData)
            .debounce(for: .seconds(0.5), scheduler: DispatchQueue.main)
            .map { searchText, newsModel in
                return self.fillterNews(text: searchText, news: newsModel ?? [])
            }
            .sink { [weak self] (artical) in
                self?.newsInfo = artical
            }.store(in: &cancellables)
    }
    // search ONline Mode 
    private func searchINServer() {
        $searchText
            .debounce(for: .seconds(0.5), scheduler: DispatchQueue.main)
            .compactMap { $0 } // Ensure the text is non-nil
            .removeDuplicates() // Optional: Remove duplicate consecutive values
            .sink { [weak self] text in
                guard let self = self else { return }
                let text = !text.isEmpty ? text : "all News"
                self.fetchNews(pageSize: self.pageSize, search: text)
            }.store(in: &cancellables)
    }
    
    func fetchNews(pageSize: Int, search: String = "all News") {
        Task{
            do{
                let result = try await homeUseCase.fetchData(pageSize: pageSize, page: page, search: search)
                DispatchQueue.main.async { [weak self] in
                    guard let self = self else {return}
                    self.newsInfo = result.articles
                    self.filterData = result.articles
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
    
    private func fillterNews(text: String, news: [Article]) -> [Article] {
        guard !text.isEmpty else{
            return news
        }
        let lowerCasedText = text.lowercased()
        return news.filter { article -> Bool in
            return article.title?.lowercased().contains(lowerCasedText) ?? false
        }
    }
}
