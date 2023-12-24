//
//  TileViewModel.swift
//  MiniMineSweeper Watch App
//
//  Created by Jari Zilverentant on 09/12/2023.
//

import Foundation

class TileViewModel: ObservableObject {
    @Published var model: TileModel

    init(tileModel: TileModel) {
        self.model = tileModel
    }

    var isRevealed: Bool {
        model.isRevealed
    }

    var isMine: Bool {
        model.isMine
    }

    var number: Int {
        model.number
    }

    var isFlag: Bool {
        model.isFlag
    }

    var isSelected: Bool {
        model.isSelected
    }

    func reset() {
        model.reset()
    }

    func toggleFlag() {
        model.toggleFlag()
    }

    func revealTile() {
        model.revealTile()
    }
}
