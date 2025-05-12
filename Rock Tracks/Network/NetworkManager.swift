//
//  NetworkManager.swift
//  Rock Tracks
//
//  Created by Yogesh Bharate on 11/05/25.
//

import Foundation

protocol NetworkProviding {
    func request(urlString: String, method: HTTPMethod, body: Data?, headers: [String: String]?) async throws -> Data
}

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
}

final class NetworkManager: NetworkProviding {
    func request(urlString: String,
                 method: HTTPMethod = .get,
                 body: Data? = nil,
                 headers: [String: String]? = nil) async throws -> Data {
        
        guard let url = URL(string: urlString) else {
            throw AppError.invalidURL
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        
        headers?.forEach { key, value in
            request.setValue(value,
                             forHTTPHeaderField: key)
        }
        
        if let body = body {
            request.httpBody = body
            request.setValue(AppConstants.applicationJson,
                             forHTTPHeaderField: AppConstants.contentType)
        }
        
        let (data, _) = try await URLSession.shared.data(for: request)
        return data
    }
}
