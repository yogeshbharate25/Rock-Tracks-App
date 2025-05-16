//
//  MockRockTracksService.swift
//  Rock TracksTests
//
//  Created by Yogesh Bharate on 15/05/25.
//

#if DEBUG
import Foundation

final class MockRockTracksService: APIServiceProviding {
    
    var isFetchRockError = false
    private(set) var isFetchRockTracksCalled = false
    func fetchRockTracks(from urlString: String) async throws -> [RockTrackResponse] {
        isFetchRockTracksCalled = true
        guard !isFetchRockError else {
            throw AppError.noData
        }
        return RockTrackResponse.arrange
    }
}
#endif
