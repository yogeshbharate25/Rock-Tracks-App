//
//  RockTracksService.swift
//  Rock Tracks
//
//  Created by Yogesh Bharate on 11/05/25.
//

import Foundation

protocol APIServiceProviding {
    func fetchRockTracks(from urlString: String) async throws -> [RockTrackResponse]
}

final class RockTracksService: APIServiceProviding {
    
    private let networkManager: NetworkProviding
    
    init(networkManager: NetworkProviding = NetworkManager()) {
        self.networkManager = networkManager
    }
    
    func fetchRockTracks(from urlString: String) async throws -> [RockTrackResponse] {
        let dataResponse = try await networkManager.request(urlString: urlString,
                                                            method: .get,
                                                            body: nil,
                                                            headers: nil)
        let response: RockTrackListResponse = try ResponseParser.decode(from: dataResponse)
        return response.results
    }
}
