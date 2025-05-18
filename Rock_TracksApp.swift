//
//  Rock_TracksApp.swift
//  Rock Tracks
//
//  Created by Yogesh Bharate on 11/05/25.
//

import SwiftUI

@main
struct Rock_TracksApp: App {
    
    var rockTrackService: APIServiceProviding {
        if AppHelper.isUITestCases {
            return MockRockTracksService()
        } else {
            return RockTracksService()
        }
    }
    
    
    var body: some Scene {
        WindowGroup {
            let viewModel = RockTrackListViewModel(service: rockTrackService)
            RockTrackListView(viewModel: viewModel)
        }
    }
}
