//
//  UIApplication+Extension.swift
//  ChessClock-Dept
//
//  Created by Ivan Jovanovik on 1.7.25.
//

import SwiftUI

extension UIApplication {
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
