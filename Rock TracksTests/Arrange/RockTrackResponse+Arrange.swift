//
//  RockTrackResponse+Arrange.swift
//  Rock TracksTests
//
//  Created by Yogesh Bharate on 15/05/25.
//
#if DEBUG
import Foundation

extension RockTrackResponse {
    static var arrange: [RockTrackResponse] {
        let data = AppHelper.load(filename: "RockTrackResponse")
        let response: RockTrackListResponse = try! ResponseParser.decode(from: data)
        return response.results
    }
}
#endif
