//
//  VoicePickerView.swift
//  Rock Tracks
//
//  Created by Yogesh Bharate on 11/06/25.
//
import SwiftUI

struct VoicePickerView: View {
    @Environment(\.dismiss) var dismiss
    @ObservedObject var speechManager: SpeechManager

    var body: some View {
        NavigationView {
            List {
                ForEach(speechManager.availableVoices, id: \.identifier) { voice in
                    HStack {
                        VStack(alignment: .leading) {
                            Text(voice.name)
                            Text(voice.language)
                                .font(.caption)
                                .foregroundColor(.gray)
                        }

                        Spacer()

                        Button("Play") {
                            speechManager.speakPreview(with: voice)
                        }

                        Button(action: {
                            speechManager.selectedVoice = voice
                            dismiss()
                        }) {
                            Image(systemName: "checkmark.circle")
                        }
                        .foregroundColor(.blue)
                    }
                }
            }
            .navigationTitle("Choose Voice")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Close") {
                        dismiss()
                    }
                }
            }
        }
    }
}

