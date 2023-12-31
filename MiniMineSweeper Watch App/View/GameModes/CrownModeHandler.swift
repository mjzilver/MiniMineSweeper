//
//  CrownModeHandler.swift
//  MiniMineSweeper Watch App
//
//  Created by Jari Zilverentant on 30/12/2023.
//

import Foundation

struct CrownModeHandler: GameModeHandler {
    var gridViewModel: GridViewModel
    
    init(gridViewModel: GridViewModel) {
        self.gridViewModel = gridViewModel
    }
    
    func handleTapGesture(tap: CGPoint) {
        gridViewModel.discoverSelectedNeighbors()
    }

    func handleLongPress(tap: CGPoint) {
        gridViewModel.setSelectedFlag()
    }

    func handleDigitalCrownRotation(gridView: GridView, value: Double) {
        let diff = value - gridView.prevScrollAmount

        if abs(diff) > GridView.scrollThreshold {
            gridView.up = (diff > 0)
            gridView.prevScrollAmount = value
            gridViewModel.selectNextTile(up: gridView.up)
        }
    }
}
