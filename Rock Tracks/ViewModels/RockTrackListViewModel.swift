//
//  RockTrackListViewModel.swift
//  Rock Tracks
//
//  Created by Yogesh Bharate on 11/05/25.
//

import Foundation

final class RockTrackListViewModel: ObservableObject {
    // MARK: - Constants
    private let service: APIServiceProviding
    
    // MARK: - Properties
    @Published var rockTracks: [RockTrackResponse] = []
    @Published var state: State = .idle
    
    init(service: APIServiceProviding = RockTracksService()) {
        self.service = service
    }
    
    @MainActor
    func fetchRockTracks() async {
        do {
            state = .loading
            let response = try await service.fetchRockTracks(from: AppConstants.rockTrackURL)
//            rockTracks = response.sorted { $0.releaseDate < $1.releaseDate }
            rockTracks = response
            state = .loaded
        } catch {
            state = .error
        }
    }
    
    func sortBy(_ type: SortType) {
        var sortedTracks: [RockTrackResponse] = []
        if type == .ascending {
            sortedTracks = rockTracks.sorted { $0.releaseDate < $1.releaseDate }
        } else {
            sortedTracks = rockTracks.sorted { $0.releaseDate > $1.releaseDate }
        }
        rockTracks = sortedTracks
    }
}

// MARK: - States
extension RockTrackListViewModel {
    enum State {
        case idle
        case loading
        case loaded
        case error
    }
}

enum SortType {
    case ascending
    case descending
}
