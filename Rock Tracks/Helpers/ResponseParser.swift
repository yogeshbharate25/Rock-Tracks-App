//
//  ResponseParser.swift
//  Rock Tracks
//
//  Created by Yogesh Bharate on 11/05/25.
//

import Foundation

protocol ResponseParserProviding {
    static func decode<T: Decodable>(from data: Data) throws -> T
}

final class ResponseParser: ResponseParserProviding {
    static func decode<T: Decodable>(from data: Data) throws -> T {
        let jsonDecoder = JSONDecoder()
        return try jsonDecoder.decode(T.self, from: data)
    }
}
