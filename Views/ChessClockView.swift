//
//  ChessClockView.swift
//  ChessClock-Dept
//
//  Created by Ivan Jovanovik on 30.6.25.
//


import SwiftUI

struct ChessClockView: View {
    @ObservedObject var viewModel: ChessClockViewModel
    @State private var customTime: Double = 180
    
    var body: some View {
        ZStack {
            ChessBoardBackground()
            VStack(spacing: 20) {
                if viewModel.showSettings {
                    
                    StyledTextField(placeholder: "Player 1 Name", text: $viewModel.playerOneName)
                    
                    StyledTextField(placeholder: "Player 2 Name", text: $viewModel.playerTwoName)
                    
                    VStack(spacing: 16) {
                        Text("Select Game Type")
                            .font(.title2.bold())
                            .foregroundColor(.white)
                        
                        VStack(spacing: 10) {
                            ForEach(TimeControl.allCases) { mode in
                                TimeControlButton(
                                    title: mode.rawValue,
                                    isSelected: viewModel.selectedTimeControl == mode,
                                    action: { viewModel.setTimeControl(mode) })
                            }
                        }
                        .padding(.horizontal)
                        
                        if viewModel.selectedTimeControl == .custom {
                            VStack(spacing: 8) {
                                Slider(value: $customTime, in: 60...3600, step: 60)
                                    .padding(.horizontal)
                                Text("Custom Time: \(Int(customTime / 60)) min")
                                    .foregroundColor(.white)
                            }
                        }
                        
                        PrimaryButton(title: "Start Game", action: {
                            viewModel.setTimeControl(viewModel.selectedTimeControl, customTime: customTime)
                            viewModel.startGame()
                        })
                    }
                    .padding()
                    .background(Color.black.opacity(0.45))
                    .cornerRadius(16)
                } else {
                    HStack(spacing: 20) {
                        PlayerClockView(title: viewModel.playerOneName, time: viewModel.playerOneTime, isActive: viewModel.activePlayer == .playerOne) {
                            viewModel.switchTurn()
                        }
                        
                        PlayerClockView(title: viewModel.playerTwoName, time: viewModel.playerTwoTime, isActive: viewModel.activePlayer == .playerTwo) {
                            viewModel.switchTurn()
                        }
                    }
                    
                    HStack(spacing: 20) {
                        PrimaryButton(
                            title: viewModel.isPaused ? "Continue" : "Pause",
                            action: {
                                viewModel.isPaused ? viewModel.resume() : viewModel.pause()
                            },
                            background: viewModel.isPaused ? .green : .orange)
                        
                        PrimaryButton(
                            title: "Reset",
                            action: {
                                viewModel.reset()
                            },
                            background: .red)
                        
                    }
                }
            }
            .padding(.vertical)
            .padding(.horizontal)
        }
        .ignoresSafeArea(.keyboard)
        .onTapGesture {
            UIApplication.shared.endEditing()
        }
    }
}
