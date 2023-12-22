//
//  NetworkService.swift
//  News App
//
//  Created by Mohamed Khaled Gomaa on 14/12/2023.
//

import Foundation

protocol APIService {
    func fetch(urlRequest: URLRequest) async throws -> Data
}

class NetworkService: APIService {
    func fetch(urlRequest: URLRequest) async throws -> Data {
        try await withCheckedThrowingContinuation { continuation in
            // Check for internet connectivity
            guard Reachability.isConnectedToNetwork() else {
                continuation.resume(throwing: AppError.noInternet)
                return
            }
            
            let task = URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
                if let error = error {
                    continuation.resume(throwing: error)
                    return
                }
                
                guard let responseData = data else {
                    continuation.resume(throwing: AppError.noData)
                    return
                }
                
                continuation.resume(returning: responseData)
            }
            
            task.resume()
            
            // Cleanup is handled automatically when the task is completed
        }
    }
}
