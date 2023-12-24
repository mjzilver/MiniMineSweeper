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
    @Binding var showingSettings: Bool
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    Button("Restart Game") {
                        gridViewModel.restartGame()
                        showingSettings.toggle()
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
