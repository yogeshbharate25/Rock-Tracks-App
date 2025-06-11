//
//  SpeechManager.swift
//  Rock Tracks
//
//  Created by Yogesh Bharate on 11/06/25.
//

import AVFoundation

class SpeechManager: NSObject, ObservableObject, AVSpeechSynthesizerDelegate {
    private let synthesizer = AVSpeechSynthesizer()
    private var utterances: [AVSpeechUtterance] = []
    private var timer: Timer?
    private var startTime: Date?
    private var totalSpeechDuration: TimeInterval = 0

    @Published var currentParagraphIndex = 0
    @Published var isSpeaking = false
    @Published var progress: Double = 0

    override init() {
        super.init()
        synthesizer.delegate = self
    }

    func toggleSpeech(for paragraphs: [String]) {
        if synthesizer.isSpeaking {
            synthesizer.pauseSpeaking(at: .immediate)
            isSpeaking = false
        } else if synthesizer.isPaused {
            synthesizer.continueSpeaking()
            isSpeaking = true
        } else {
            utterances = paragraphs.map {
                let utterance = AVSpeechUtterance(string: $0)
                utterance.voice = AVSpeechSynthesisVoice(language: "en-US")
                return utterance
            }
            currentParagraphIndex = 0
            totalSpeechDuration = estimateTotalDuration(for: utterances)
            startTime = Date()
            progress = 0
            synthesizer.speak(utterances[currentParagraphIndex])
            isSpeaking = true
            startTimer()
        }
    }

    func skip(by seconds: TimeInterval) {
        synthesizer.stopSpeaking(at: .immediate)
        guard let startTime = startTime else { return }
        let newElapsed = Date().timeIntervalSince(startTime) + seconds
        let clampedTime = max(0, min(totalSpeechDuration, newElapsed))
        let newIndex = paragraphIndex(for: clampedTime)
        currentParagraphIndex = newIndex
        synthesizer.speak(utterances[currentParagraphIndex])
        self.startTime = Date().addingTimeInterval(-clampedTime)
    }

    func estimateTotalDuration(for utterances: [AVSpeechUtterance]) -> TimeInterval {
        TimeInterval(utterances.reduce(0) { $0 + ($1.speechString.count / 13) }) // Rough estimate
    }

    func paragraphIndex(for time: TimeInterval) -> Int {
        var elapsed: TimeInterval = 0
        for (i, u) in utterances.enumerated() {
            elapsed += Double(u.speechString.count) / 13
            if time < elapsed { return i }
        }
        return utterances.count - 1
    }

    func startTimer() {
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true) { _ in
            guard let startTime = self.startTime else { return }
            let elapsed = Date().timeIntervalSince(startTime)
            self.progress = min(1, elapsed / self.totalSpeechDuration)
        }
    }

    func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didFinish utterance: AVSpeechUtterance) {
        if currentParagraphIndex + 1 < utterances.count {
            currentParagraphIndex += 1
            synthesizer.speak(utterances[currentParagraphIndex])
        } else {
            isSpeaking = false
            timer?.invalidate()
            progress = 1
        }
    }
}

