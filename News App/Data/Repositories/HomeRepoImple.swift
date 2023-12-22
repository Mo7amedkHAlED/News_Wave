//
//  HomeRepoImple.swift
//  News App
//
//  Created by Mohamed Khaled Gomaa on 16/12/2023.
//

import Foundation
import Combine

class HomeRepoImple :HomeRepoProtocol {
    private let networkService: NetworkClientType
    
    init(networkService: NetworkClientType = NetworkClient()) {
        self.networkService = networkService
    }
    
    func fetchData(pageSize: Int, page: Int, search: String) async throws -> NewsModel {
        let urlParameters: [String: Any] = [Constants.Parameter.search: search,
                                            Constants.Parameter.page: page,
                                            Constants.Parameter.pageSize: pageSize,
                                            Constants.Parameter.language: "en",
                                            Constants.Parameter.apiKey : Constants.apiKey]
        
        let urlRequest = URLRequestManger.buildRequest(path: "/v2/everything", method: .get,urlParameters: urlParameters)
        do {
            // Specify the type you expect the response to be
            let responseData: NewsModel = try await networkService.sendRequest(request: urlRequest)
            return responseData
        } catch {
            throw error
        }
    }
}
