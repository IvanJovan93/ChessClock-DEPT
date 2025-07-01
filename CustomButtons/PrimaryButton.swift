//
//  PrimaryButton.swift
//  ChessClock-Dept
//
//  Created by Ivan Jovanovik on 1.7.25.
//

import SwiftUI

struct PrimaryButton: View {
    let title: String
    let action: () -> Void
    var background: Color = .blue
    var textColor: Color = .white

    var body: some View {
        Button(action: action) {
            Text(title)
                .frame(maxWidth: .infinity, minHeight: 50)
                .font(.title3.bold())
                .padding(.horizontal)
        }
        .background(background)
        .foregroundColor(textColor)
        .cornerRadius(10)
    }
}
