//
//  ChessBoardBackground.swift
//  ChessClock-Dept
//
//  Created by Ivan Jovanovik on 30.6.25.
//


import SwiftUI

struct ChessBoardBackground: View {
    var body: some View {
        GeometryReader { geo in
            let squareSize = geo.size.width / 8
            let rowCount = Int(geo.size.height / squareSize) + 1

            VStack(spacing: 0) {
                ForEach(0..<rowCount, id: \.self) { row in
                    HStack(spacing: 0) {
                        ForEach(0..<8) { col in
                            Rectangle()
                                .fill((row + col).isMultiple(of: 2) ? Color.lightSquare : Color.darkSquare)
                                .frame(width: squareSize, height: squareSize)
                        }
                    }
                }
            }
        }
        .ignoresSafeArea()
    }
}

