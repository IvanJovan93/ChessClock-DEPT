//
//  TimeControl.swift
//  ChessClock-Dept
//
//  Created by Ivan Jovanovik on 30.6.25.
//

import Foundation

enum TimeControl: String, CaseIterable, Identifiable {
    var id: String { rawValue }

    case blitz = "Blitz (5 min)"
    case rapid = "Rapid (10 min)"
    case classical = "Classical (30 min)"
    case custom = "Custom"

    var time: TimeInterval {
        switch self {
        case .blitz: return 5 * 60
        case .rapid: return 10 * 60
        case .classical: return 30 * 60
        case .custom: return 3 * 60
        }
    }
}
