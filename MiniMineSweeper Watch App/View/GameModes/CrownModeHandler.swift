//
//  CrownModeHandler.swift
//  MiniMineSweeper Watch App
//
//  Created by Jari Zilverentant on 30/12/2023.
//

import Foundation

struct CrownModeHandler: GameModeHandler {
    func handleTapGesture(gridViewModel: GridViewModel, tap: CGPoint) {
        gridViewModel.discoverSelectedNeighbors()
    }

    func handleLongPress(gridViewModel: GridViewModel, tap: CGPoint) {
        gridViewModel.setSelectedFlag()
    }

    func handleDigitalCrownRotation(gridViewModel: GridViewModel, gridView: GridView, value: Double) {
        let diff = value - gridView.prevScrollAmount

        if abs(diff) > GridView.scrollThreshold {
            gridView.up = (diff > 0)
            gridView.prevScrollAmount = value
            gridViewModel.selectNextTile(up: gridView.up)
        }
    }
}
