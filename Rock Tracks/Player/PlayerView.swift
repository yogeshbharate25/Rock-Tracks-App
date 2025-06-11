//
//  PlayerView.swift
//  Rock Tracks
//
//  Created by Yogesh Bharate on 11/06/25.
//

import SwiftUI
import AVFoundation

struct ParagraphReaderView: View {
    @StateObject private var speechManager = SpeechManager()
    @State private var paragraphs: [String] = [
        "This is the first paragraph.",
        "Here is the second paragraph being read.",
        "This is the third and final paragraph."
    ]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            ScrollView {
                ForEach(paragraphs.indices, id: \.self) { index in
                    Text(paragraphs[index])
                        .padding()
                        .background(speechManager.currentParagraphIndex == index ? Color.yellow.opacity(0.3) : Color.clear)
                        .cornerRadius(8)
                }
            }
            
            Slider(value: $speechManager.progress, in: 0...1)
                .padding()

            HStack {
                Button(action: {
                    speechManager.skip(by: -10)
                }) {
                    Label("Back 10s", systemImage: "gobackward.10")
                }
                
                Spacer()
                
                Button(action: {
                    speechManager.toggleSpeech(for: paragraphs)
                }) {
                    Image(systemName: speechManager.isSpeaking ? "pause.circle.fill" : "play.circle.fill")
                        .font(.largeTitle)
                }

                Spacer()
                
                Button(action: {
                    speechManager.skip(by: 10)
                }) {
                    Label("Forward 10s", systemImage: "goforward.10")
                }
            }
            .padding(.horizontal)
        }
        .padding()
    }
}

