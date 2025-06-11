//
//  PlayerView.swift
//  Rock Tracks
//
//  Created by Yogesh Bharate on 11/06/25.
//

import SwiftUI
import AVFoundation

struct ParagraphReaderView: View {
    @State private var showVoicePicker = false
    @StateObject private var speechManager = SpeechManager()
    @State private var paragraphs: [String] = [
        "Xcode 26 beta includes SDKs for iOS 26, iPadOS 26, tvOS 26, watchOS 26, macOS Tahoe 26, and visionOS 26. The Xcode 26 beta release supports on-device debugging in iOS 16 and later, tvOS 16 and later, watchOS 8 and later, and visionOS. Xcode 26 beta requires a Mac running macOS Sequoia 15.4 or later.",
        "Fixed: The alert shown when a file, project, or workspace is modified by a different program while also opened in Xcode had inconsistent button labeling, and the default action did not always keep the Xcode version of the file. (86281699)",
        "The span property of UTF8View does not support the small string representation in beta 1, and traps for small String instances. A future version of the Swift standard library will lift this restriction. (137710901)",
        "Workaround: As a workaround, reserve capacity for 16 UTF8 code units, which forces the String to use another representation.",
        "Xcode 26 beta includes SDKs for iOS 26, iPadOS 26, tvOS 26, watchOS 26, macOS Tahoe 26, and visionOS 26. The Xcode 26 beta release supports on-device debugging in iOS 16 and later, tvOS 16 and later, watchOS 8 and later, and visionOS. Xcode 26 beta requires a Mac running macOS Sequoia 15.4 or later.",
        "Fixed: The alert shown when a file, project, or workspace is modified by a different program while also opened in Xcode had inconsistent button labeling, and the default action did not always keep the Xcode version of the file. (86281699)"
    ]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            ScrollViewReader { proxy in
                ScrollView {
                    ForEach(paragraphs.indices, id: \.self) { index in
                        Text(paragraphs[index])
                            .padding()
                            .background(speechManager.currentParagraphIndex == index ? Color.yellow.opacity(0.3) : Color.clear)
                            .cornerRadius(8)
                    }
                }
                .onChange(of: speechManager.currentParagraphIndex) { newIndex in
                    withAnimation {
                        proxy.scrollTo(newIndex, anchor: .center)
                    }
                }
            }
            
            Slider(value: $speechManager.progress, in: 0...1)
                .padding()

            HStack {
                Button("Choose Voice") {
                    showVoicePicker.toggle()
                }
                
                Spacer()
                
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
        .sheet(isPresented: $showVoicePicker) {
            VoicePickerView(speechManager: speechManager)
        }
        .padding()
    }
}

