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
    private var elapsedTime: TimeInterval = 0

    @Published var selectedVoice: AVSpeechSynthesisVoice? = AVSpeechSynthesisVoice(language: "en-US")
    @Published var currentParagraphIndex = 0
    @Published var isSpeaking = false
    @Published var progress: Double = 0
    @Published var availableVoices: [AVSpeechSynthesisVoice] = []

    override init() {
        super.init()
        synthesizer.delegate = self
        loadVoices()
    }
    
    func loadVoices() {
        availableVoices = AVSpeechSynthesisVoice.speechVoices().filter { $0.language.starts(with: "en") }
    }
    
    func speakPreview(text: String = "Hello! This is a voice preview.", with voice: AVSpeechSynthesisVoice) {
        let utterance = AVSpeechUtterance(string: text)
        utterance.voice = voice
        synthesizer.speak(utterance)
    }

    func toggleSpeech(for paragraphs: [String]) {
        if synthesizer.isSpeaking {
            synthesizer.pauseSpeaking(at: .immediate)
            isSpeaking = false
            stopTimer() // 🛑 Stop updating the slider
        } else if synthesizer.isPaused {
            synthesizer.continueSpeaking()
            isSpeaking = true
            startTime = Date().addingTimeInterval(-elapsedTime)
            startTimer() // ▶️ Resume slider updates
        } else {
            // Starting from the beginning
            utterances = paragraphs.map {
                let utterance = AVSpeechUtterance(string: $0)
                utterance.voice = selectedVoice
                return utterance
            }
            currentParagraphIndex = 0
            totalSpeechDuration = estimateTotalDuration(for: utterances)
            startTime = Date()
            elapsedTime = 0
            progress = 0
            isSpeaking = true
            synthesizer.speak(utterances[currentParagraphIndex])
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
            stopTimer()
            progress = 1
            elapsedTime = 0
        }
    }
    
    func stopTimer() {
        if let startTime = startTime {
            elapsedTime += Date().timeIntervalSince(startTime)
        }
        timer?.invalidate()
        timer = nil
    }
}

