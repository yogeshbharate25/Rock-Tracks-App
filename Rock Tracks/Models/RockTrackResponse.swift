//
//  RockTrackResponse.swift
//  Rock Tracks
//
//  Created by Yogesh Bharate on 11/05/25.
//

import Foundation

struct RockTrackResponse: Decodable {
    let trackId: Int
    let trackName: String
    let artistName: String
    let artworkUrl60: String
    let artworkUrl100: String
    let trackTimeMillis: Int
    let releaseDate: String
    let trackPrice: Double
    let trackViewUrl: String
}

struct RockTrackListResponse: Decodable {
    let results: [RockTrackResponse]
}
