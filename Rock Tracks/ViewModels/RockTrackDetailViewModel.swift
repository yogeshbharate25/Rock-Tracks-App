//
//  RockTrackDetailViewModel.swift
//  Rock Tracks
//
//  Created by Yogesh Bharate on 14/05/25.
//

import Foundation

struct RockTrackDetailViewModel {
    
    let track: RockTrackResponse
    
    
    func getTrackDuration(trackTimeMillis: Int) -> String {
        let minutes = trackTimeMillis / 60000
        let seconds = (trackTimeMillis % 60000) / 1000
        return String(format: "%02d:%02d", minutes, seconds)
    }
    
    func formatDate(_ input: String) -> String {
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        inputFormatter.locale = Locale(identifier: "en_US_POSIX")

        let outputFormatter = DateFormatter()
        outputFormatter.dateFormat = "dd MMMM yyyy"

        if let date = inputFormatter.date(from: input) {
            return outputFormatter.string(from: date)
        } else {
            return ""
        }
    }
}
