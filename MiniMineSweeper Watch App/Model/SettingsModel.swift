//
//  SettingsModel.swift
//  MiniMineSweeper Watch App
//
//  Created by Jari Zilverentant on 27/12/2023.
//

import Foundation

class SettingsModel: ObservableObject {
    @Published var crownMode: Bool
    @Published var pictureMode: Bool
    @Published var minePercentage: Double
    @Published var minePercentageStep: Double
    @Published var gameMode: GameMode
    
    init(crownMode: Bool = false, pictureMode: Bool = false, minePercentage: Double = 0.05, minePercentageStep: Double = 0.05, gameMode: GameMode = .crown) {
        self.crownMode = crownMode
        self.pictureMode = pictureMode
        self.minePercentage = minePercentage
        self.minePercentageStep = minePercentageStep
        self.gameMode = gameMode
    }
}
