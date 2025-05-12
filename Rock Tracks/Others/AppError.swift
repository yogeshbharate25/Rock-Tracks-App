//
//  AppError.swift
//  Rock Tracks
//
//  Created by Yogesh Bharate on 11/05/25.
//

import Foundation

enum AppError: Error {
    case invalidURL
    case noData
    case requestFailed
    case parsingFailed
    
    var errorDescriptionL: String {
        switch self {
        case .invalidURL:
            return "Invalid URL"
        case .noData:
            return "No data"
        case .requestFailed:
            return "Request failed"
        case .parsingFailed:
            return "Parsing failed"
        }
    }
}
