//
//  RockTrackDetailView.swift
//  Rock Tracks
//
//  Created by Yogesh Bharate on 11/05/25.
//

import SwiftUI

struct RockTrackDetailView: View {
    
    let track: RockTrackResponse
    @Environment(\.presentationMode) private var presentationMode
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            imageView
            trackDetailView
            Spacer()
                .frame(height: 24)
            bottomButtonView
            Spacer()
        }
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }) {
                    Image(systemName: "chevron.backward")
                        .font(.system(size: 20, weight: .bold))
                        .foregroundColor(.white)
                }
            }
        }
        .ignoresSafeArea()
    }
    
    private var imageView: some View {
        AsyncImage(url: URL(string: track.artworkUrl100)) { image in
            image
                .resizable()
                .aspectRatio(contentMode: .fit)
        } placeholder: {
            ProgressView()
                .foregroundColor(.white)
                .frame(height: 120)
                .frame(maxWidth: .infinity)
                .background(Color(.lightGray))
        }
        .frame(maxWidth: .infinity)
    }
    
    private var trackDetailView: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(track.trackName)
                .font(.system(size: 20, weight: .semibold))
                .foregroundStyle(.black)
            Text(track.artistName)
                .font(.system(size: 18))
                .foregroundStyle(.gray)
            Text(String(format: "%.2f", track.trackPrice))
                .font(.system(size: 18, weight: .medium))
                .foregroundStyle(.gray)
            Spacer()
                .frame(height: 16)
            Text(track.duration)
                .font(.system(size: 18, weight: .medium))
                .foregroundStyle(.gray)
            Text(track.releaseDate)
                .font(.system(size: 18, weight: .medium))
                .foregroundStyle(.gray)
        }
        .padding(16)
    }
    
    private var bottomButtonView: some View {
        VStack {
            Button(action: buttonTapped) {
                Text("More details")
                    .font(.system(size: 20, weight: .medium))
                    .padding()
                    .frame(maxWidth: .infinity)
            }
            .buttonStyle(.bordered)
            .padding(16)
        }
    }
    
    func buttonTapped() {
        if let url = URL(string: track.trackViewUrl),
           UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url)
        }
    }
}
