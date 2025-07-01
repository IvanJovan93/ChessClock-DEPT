//
//  TimeControlButton.swift
//  ChessClock-Dept
//
//  Created by Ivan Jovanovik on 1.7.25.
//

import SwiftUI

struct TimeControlButton: View {
    let title: String
    let isSelected: Bool
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Text(title)
                .frame(maxWidth: .infinity, minHeight: 50)
                .padding()
                .background(isSelected ? Color.blue : Color.white.opacity(0.2))
                .foregroundColor(.white)
                .cornerRadius(10)
        }
    }
}
