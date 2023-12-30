//
//  SettingsViewModel.swift
//  MiniMineSweeper Watch App
//
//  Created by Jari Zilverentant on 27/12/2023.
//


import Foundation
import Combine

class SettingsViewModel: ObservableObject {
    @Published var model: SettingsModel

    init() {
        model = SettingsModel()
    }
}
