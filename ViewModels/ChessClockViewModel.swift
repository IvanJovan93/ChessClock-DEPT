//
//  ChessClockViewModel.swift
//  ChessClock-Dept
//
//  Created by Ivan Jovanovik on 30.6.25.
//


import Foundation
import Combine
import AVFoundation
import SwiftUI

class ChessClockViewModel: ObservableObject {
    @Published var playerOneTime: TimeInterval
    @Published var playerTwoTime: TimeInterval
    @Published var activePlayer: Player? = nil
    @Published var isPaused = true
    @Published var showSettings = true
    @Published var playerOneName: String = "Player 1"
    @Published var playerTwoName: String = "Player 2"

    var selectedTimeControl: TimeControl = .blitz

    private var timer: AnyCancellable?
    private var impactFeedback = UIImpactFeedbackGenerator(style: .medium)
    private var player: AVAudioPlayer?

    init() {
        playerOneTime = selectedTimeControl.time
        playerTwoTime = selectedTimeControl.time
        prepareSound()
    }

    func setTimeControl(_ control: TimeControl, customTime: TimeInterval? = nil) {
        selectedTimeControl = control
        let time = control == .custom ? (customTime ?? 180) : control.time
        reset(time: time)
    }

    func startGame() {
        isPaused = false
        activePlayer = .playerOne
        startTimer()
        showSettings = false
    }

    func pause() {
        isPaused = true
        timer?.cancel()
    }
    
    func resume() {
        isPaused = false
        startTimer()
    }

    func reset(time: TimeInterval? = nil) {
        pause()
        let t = time ?? selectedTimeControl.time
        playerOneTime = t
        playerTwoTime = t
        activePlayer = nil
        showSettings = true
    }

    func switchTurn() {
        guard !isPaused else { return }
        activePlayer = activePlayer == .playerOne ? .playerTwo : .playerOne
        impactFeedback.impactOccurred()
        playSound()
    }

    private func startTimer() {
        timer?.cancel()
        timer = Timer.publish(every: 1, on: .main, in: .common)
            .autoconnect()
            .sink { [weak self] _ in self?.tick() }
    }

    private func tick() {
        guard !isPaused, let active = activePlayer else { return }
        withAnimation(.easeInOut(duration: 0.25)) {
            switch active {
            case .playerOne:
                playerOneTime = max(playerOneTime - 1, 0)
            case .playerTwo:
                playerTwoTime = max(playerTwoTime - 1, 0)
            }
        }
        if playerOneTime == 0 || playerTwoTime == 0 {
            pause()
        }
    }

    private func prepareSound() {
        guard let soundURL = Bundle.main.url(forResource: "tick", withExtension: "MP3") else { return }
        player = try? AVAudioPlayer(contentsOf: soundURL)
        player?.prepareToPlay()
    }

    private func playSound() {
        guard let player = player else { return }
        player.play()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            player.stop()
        }
    }
}
