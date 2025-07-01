//
//  StyledTextField.swift
//  ChessClock-Dept
//
//  Created by Ivan Jovanovik on 1.7.25.
//


import SwiftUI

struct StyledTextField: View {
    let placeholder: String
    @Binding var text: String

    var body: some View {
        TextField(placeholder, text: $text)
            .foregroundColor(.black)
            .padding(.horizontal)
            .frame(height: 50)
            .background(Color.textFieldPrimaryColor)
            .cornerRadius(8)
            .overlay(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(Color.gray.opacity(0.6), lineWidth: 1)
            )
            .disableAutocorrection(true)
            .autocapitalization(.words)
            .padding(.horizontal)
    }
}
