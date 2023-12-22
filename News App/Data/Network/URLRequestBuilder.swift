//
//  URLRequestBuilder.swift
//  News App
//
//  Created by Mohamed Khaled Gomaa on 17/12/2023.
//

import Foundation

struct URLRequestBuilder {
    
    private var baseUrl: String
    private var path: String
    private var method: HTTPMethod
    private var headers: [String: String]
    private var parameters: [String: Any]
    private var body: Encodable?

    init(baseUrl: String, path: String) {
        self.baseUrl = baseUrl
        self.path = path
        self.method = .get
        self.headers = [:]
        self.parameters = [:]
        self.body = nil
    }

    func set(method: HTTPMethod) -> URLRequestBuilder {
        var builder = self
        builder.method = method
        return builder
    }

    func set(headers: [String: String]) -> URLRequestBuilder {
        var builder = self
        builder.headers = headers
        return builder
    }

    func set(parameters: [String: Any]) -> URLRequestBuilder {
        var builder = self
        builder.parameters = parameters
        return builder
    }

    func set(body: Encodable?) -> URLRequestBuilder {
        var builder = self
        builder.body = body
        return builder
    }

    func build() -> URLRequest {
        var urlComponents = URLComponents(string: baseUrl)!
        urlComponents.path = path
        urlComponents.queryItems = parameters.map { URLQueryItem(name: $0.key, value: String(describing: $0.value)) }

        var request = URLRequest(url: urlComponents.url!)
        request.httpMethod = method.rawValue
        request.allHTTPHeaderFields = headers

        if let body = body {
            request.httpBody = try? JSONEncoder().encode(body)
        }
        return request
    }
}
