//
//  RockTrackListView.swift
//  Rock Tracks
//
//  Created by Yogesh Bharate on 11/05/25.
//

import SwiftUI

struct RockTrackListView: View {
    
    @ObservedObject var viewModel: RockTrackListViewModel = .init()
    @State var sortType: SortType = .ascending
    
    var body: some View {
        VStack {
            switch viewModel.state {
            case .loading, .idle:
                ProgressView()
            case .loaded:
                loadedView
            case .error:
                Text(AppError.genericError.errorDescription)
                    .font(.system(size: 20, weight: .semibold))
                    .foregroundStyle(.black)
            }
        }
        .onAppear {
            Task {
                await viewModel.fetchRockTracks()
            }
        }
    }
    
    private var loadedView: some View {
        NavigationView {
            VStack(spacing: 16) {
                sortView
                rockTrackList
            }
            .navigationTitle(AppConstants.title)
            .navigationBarTitleDisplayMode(.inline)
        }
    }
    
    private var sortView: some View {
        Text("Sort By")
            .font(.title)
            .padding(16)
            .onTapGesture {
                sortType = sortType == .ascending ? .descending : .ascending
                viewModel.sortBy(sortType)
            }
    }
    
    private var rockTrackList: some View {
            ScrollView {
                VStack(alignment: .leading, spacing: 8) {
                    ForEach(viewModel.rockTracks, id: \.trackId) { track in
                        NavigationLink(destination: RockTrackDetailView(viewModel: .init(track: track))) {
                            HStack(spacing: 16) {
                                getTrackImageView(track.artworkUrl60)
                                getTrackListView(track)
                            }
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .overlay(RoundedRectangle(cornerRadius: 4)
                                .stroke(.gray, lineWidth: 0.8))
                            .padding(EdgeInsets(top: 4, leading: 16, bottom: 4, trailing: 16))
                        }
                    }
                }
            }
    }
    
    private func getTrackImageView(_ trackURL: String) -> some View {
        VStack(spacing: 0) {
            if AppHelper.isUITestCases {
                defaultImageView
            } else {
                AsyncImage(url: URL(string: trackURL)) { phase in
                    switch phase {
                    case .empty:
                        ProgressView()
                    case .success(let image):
                        image
                            .resizable()
                            .scaledToFit()
                    case .failure:
                        defaultImageView
                    @unknown default:
                        EmptyView()
                    }
                }
            }
        }
        .frame(width: 120, height: 120)
    }
    
    private func getTrackListView(_ track: RockTrackResponse) -> some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(track.trackName)
                .font(.system(size: 20, weight: .semibold))
                .foregroundStyle(.black)
                .accessibilityIdentifier("trackListView.\(track.trackId).trackName")
            Text(track.artistName)
                .font(.system(size: 18))
                .foregroundStyle(.gray)
                .accessibilityIdentifier("trackListView.\(track.trackId).artistName")
            Text(String(format: "%.2f", track.trackPrice))
                .font(.system(size: 18, weight: .medium))
                .foregroundStyle(.gray)
                .accessibilityIdentifier("trackListView.\(track.trackId).trackPrice")
        }
    }
    
    private var defaultImageView: some View {
        Image(systemName: "photo")
            .resizable()
            .scaledToFit()
            .foregroundColor(.gray)
    }
}
