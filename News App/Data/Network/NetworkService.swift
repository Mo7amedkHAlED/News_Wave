//
//  NetworkService.swift
//  News App
//
//  Created by Mohamed Khaled Gomaa on 14/12/2023.
//

import Foundation

protocol NetworkClientType {
     func sendRequest<ResponseType>(request: URLRequest) async throws -> ResponseType where ResponseType: Decodable
}

class NetworkClient: NetworkClientType {
    func sendRequest<ResponseType>(request: URLRequest) async throws -> ResponseType where ResponseType: Decodable {
        try await withCheckedThrowingContinuation { continuation in
            // Check for internet connectivity
            guard Reachability.isConnectedToNetwork() else {
                continuation.resume(throwing: AppError.noInternet)
                return
            }

            let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
                if let error = error {
                    continuation.resume(throwing: error)
                    return
                }
                
                guard let responseData = data else {
                    continuation.resume(throwing: AppError.noData)
                    return
                }
                
                do {
                    let decodedResponse = try JSONDecoder().decode(ResponseType.self, from: responseData)
                    continuation.resume(returning: decodedResponse)
                } catch {
                    continuation.resume(throwing: error)
                }
            }
            
            task.resume()
            
            // Cleanup is handled automatically when the task is completed
        }
    }
}
