//
//  PlayerClockView.swift
//  ChessClock-Dept
//
//  Created by Ivan Jovanovik on 30.6.25.
//


import SwiftUI

struct PlayerClockView: View {
    let title: String
    let time: TimeInterval
    let isActive: Bool
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            VStack {
                Text(title.isEmpty ? "Player" : title)
                    .font(.headline)
                    .foregroundColor(.white)
                Text(formatTime(time))
                    .font(.largeTitle)
                    .bold()
                    .foregroundColor(.white)
            }
            .frame(maxWidth: .infinity, minHeight: 200)
            .background(isActive ? Color.green : Color.gray)
            .cornerRadius(20)
            .shadow(radius: 5)
        }
    }

    func formatTime(_ time: TimeInterval) -> String {
        let minutes = Int(time) / 60
        let seconds = Int(time) % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
}
