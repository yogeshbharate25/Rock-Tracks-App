//
//  MockNetworkManager.swift
//  Rock TracksTests
//
//  Created by Yogesh Bharate on 15/05/25.
//

import Foundation
@testable import Rock_Tracks

final class MockNetworkManager: NetworkProviding {
    var mockResponse: Data?
    var isNetworkError = false
    func request(urlString: String,
                 method: HTTPMethod,
                 body: Data?,
                 headers: [String : String]?) async throws -> Data {
        guard !isNetworkError else {
            throw AppError.genericError
        }
        return mockResponse ?? Data()
    }
}
