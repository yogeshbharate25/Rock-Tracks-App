//
//  RockTrackDetailView.swift
//  Rock Tracks
//
//  Created by Yogesh Bharate on 11/05/25.
//

import SwiftUI

struct RockTrackDetailView: View {
    
    let viewModel: RockTrackDetailViewModel
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
        VStack(spacing: 0) {
            if AppHelper.isUITestCases {
                Image(systemName: "photo")
                    .resizable()
                    .scaledToFit()
                    .foregroundColor(.gray)
            } else {
                AsyncImage(url: URL(string: viewModel.track.artworkUrl100)) { image in
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
            }
        }
        .frame(maxWidth: .infinity)
    }
    
    private var trackDetailView: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(viewModel.track.trackName)
                .font(.system(size: 20, weight: .semibold))
                .foregroundStyle(.black)
                .accessibilityIdentifier("trackDetailView.\(viewModel.track.trackId).trackName")
            Text(viewModel.track.artistName)
                .font(.system(size: 18))
                .foregroundStyle(.gray)
                .accessibilityIdentifier("trackDetailView.\(viewModel.track.trackId).artistName")
            Text(String(format: "%.2f", viewModel.track.trackPrice))
                .font(.system(size: 18, weight: .medium))
                .foregroundStyle(.gray)
                .accessibilityIdentifier("trackDetailView.\(viewModel.track.trackId).trackPrice")
            Spacer()
                .frame(height: 16)
            Text(viewModel.getTrackDuration(trackTimeMillis: viewModel.track.trackTimeMillis))
                .font(.system(size: 18, weight: .medium))
                .foregroundStyle(.gray)
                .accessibilityIdentifier("trackDetailView.\(viewModel.track.trackId).trackDuration")
            Text(viewModel.formatDate(viewModel.track.releaseDate))
                .font(.system(size: 18, weight: .medium))
                .foregroundStyle(.gray)
                .accessibilityIdentifier("trackDetailView.\(viewModel.track.trackId).releaseDate")
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
            .accessibilityIdentifier("trackDetailView.moreDetails.button")
        }
    }
    
    func buttonTapped() {
        if let url = URL(string: viewModel.track.trackViewUrl),
           UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url)
        }
    }
}
