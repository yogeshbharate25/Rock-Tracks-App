//
//  Rock_TracksApp.swift
//  Rock Tracks
//
//  Created by Yogesh Bharate on 11/05/25.
//

import AVFoundation
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
    
    init() {
        setupAudioSession()
    }
    
    
    var body: some Scene {
        WindowGroup {
//            let viewModel = RockTrackListViewModel(service: rockTrackService)
//            RockTrackListView(viewModel: viewModel)
            ParagraphReaderView()
        }
    }
    
    private func setupAudioSession() {
        do {
            let session = AVAudioSession.sharedInstance()
            try session.setCategory(.playback, mode: .spokenAudio, options: [])
            try session.setActive(true)
        } catch {
            print("⚠️ Failed to configure audio session: \(error)")
        }
    }
}
