//
//  SettingsModel.swift
//  MiniMineSweeper Watch App
//
//  Created by Jari Zilverentant on 27/12/2023.
//

import Foundation

class SettingsModel: ObservableObject, Codable {
    @Published var crownMode: Bool
    @Published var pictureMode: Bool
    @Published var minePercentage: Double
    @Published var minePercentageStep: Double
    @Published var gameMode: GameMode
    
    private enum CodingKeys: String, CodingKey {
        case crownMode
        case pictureMode
        case minePercentage
        case minePercentageStep
        case gameMode
    }
    
    init(crownMode: Bool = false, pictureMode: Bool = false, minePercentage: Double = 0.05, minePercentageStep: Double = 0.05, gameMode: GameMode = .crown) {
        self.crownMode = crownMode
        self.pictureMode = pictureMode
        self.minePercentage = minePercentage
        self.minePercentageStep = minePercentageStep
        self.gameMode = gameMode
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        crownMode = try container.decode(Bool.self, forKey: .crownMode)
        pictureMode = try container.decode(Bool.self, forKey: .pictureMode)
        minePercentage = try container.decode(Double.self, forKey: .minePercentage)
        minePercentageStep = try container.decode(Double.self, forKey: .minePercentageStep)
        gameMode = try container.decode(GameMode.self, forKey: .gameMode)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(crownMode, forKey: .crownMode)
        try container.encode(pictureMode, forKey: .pictureMode)
        try container.encode(minePercentage, forKey: .minePercentage)
        try container.encode(minePercentageStep, forKey: .minePercentageStep)
        try container.encode(gameMode, forKey: .gameMode)
    }
}

