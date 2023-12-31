//
//  SettingsViewModel.swift
//  MiniMineSweeper Watch App
//
//  Created by Jari Zilverentant on 27/12/2023.
//


import Foundation
import Combine

class SettingsViewModel: ObservableObject {
    @Published var model: SettingsModel {
        didSet {
            saveSettings()
        }
    }

    private let settingsKey = "MiniMineSweeperSettings"

    init() {
        if let savedSettingsData = UserDefaults.standard.data(forKey: settingsKey),
           let decodedSettings = try? JSONDecoder().decode(SettingsModel.self, from: savedSettingsData) {
            model = decodedSettings
        } else {
            model = SettingsModel()
        }
        objectWillChange.send()
    }
    
    var gameMode: GameMode {
        model.gameMode
    }

    private func saveSettings() {
        if let encodedSettings = try? JSONEncoder().encode(model) {
            UserDefaults.standard.set(encodedSettings, forKey: settingsKey)
        }
    }
}

