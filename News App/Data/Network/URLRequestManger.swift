//
//  URLRequestManger.swift
//  News App
//
//  Created by Mohamed Khaled Gomaa on 17/12/2023.
//

import Foundation

struct URLRequestManger {

    static func buildRequest(baseUrl: String = Constants.baseURL,
                             path: String,
                             method: HTTPMethod = .get,
                             urlParameters: [String: Any] = [:],
                             body: Encodable? = nil) -> URLRequest {
        return URLRequestBuilder(baseUrl: baseUrl, path: path)
            .set(method: method)
            .set(headers: getHeaders())
            .set(parameters: urlParameters)
            .set(body: body)
            .build()
    }

    private static func getHeaders() -> [String: String] {
        return [Constants.Header.contentType : Constants.ContentType.json]
    }
}
