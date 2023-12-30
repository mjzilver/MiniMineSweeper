//
//  SettingsView.swift
//  MiniMineSweeper Watch App
//
//  Created by Jari Zilverentant on 24/12/2023.
//

import Foundation
import SwiftUI

struct SettingsView: View {
    @ObservedObject var gridViewModel: GridViewModel
    @ObservedObject var settingsViewModel: SettingsViewModel
    @Binding var showingSettings: Bool
    
    init(gridViewModel: GridViewModel, showingSettings: Binding<Bool>) {
        self.gridViewModel = gridViewModel
        self.settingsViewModel = gridViewModel.settingsViewModel
        self._showingSettings = showingSettings
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    Button("Restart Game") {
                        gridViewModel.restartGame()
                        showingSettings = false
                    }
                }
                Section {
                    Picker("Game Mode", selection: $settingsViewModel.model.gameMode) {
                        ForEach(GameMode.allCases, id: \.self) { mode in
                            Text(mode.rawValue)
                        }
                    }
                }
                Section {
                    Text("Mine Percentage: \(String(format: "%.0f%%", gridViewModel.model.percentMines * 100))")
                    Slider(
                        value: $gridViewModel.model.percentMines,
                        in: 0.10...0.90,
                        step: 0.05
                    )
                }
            }
        }
    }
}
