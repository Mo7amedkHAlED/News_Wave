//
//  HeadlineRepoImple.swift
//  News App
//
//  Created by Mohamed Khaled Gomaa on 18/12/2023.
//

import Foundation
import Combine

class HeadlineRepoImple: HeadlLineRepoProtocol{
    private let networkService: NetworkClientType
    
    init(networkService: NetworkClientType = NetworkClient()) {
        self.networkService = networkService
    }
    
    func fetchHeadlines(pageSize: Int, page: Int) async throws -> NewsModel {
        let urlParameters: [String: Any] = [
            Constants.Parameter.pageSize: pageSize,
            Constants.Parameter.page: page,
            Constants.Parameter.language: "en",
            Constants.Parameter.apiKey : Constants.apiKey]
        let request = URLRequestManger.buildRequest(path: "/v2/top-headlines",method: .get,urlParameters: urlParameters)
        do{
            let responesData: NewsModel = try await networkService.sendRequest(request: request)
            return responesData
        } catch{
            throw error
        }
    }
}

