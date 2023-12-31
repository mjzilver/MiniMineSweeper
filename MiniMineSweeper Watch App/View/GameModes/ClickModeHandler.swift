//
//  ClickModeHandler.swift
//  MiniMineSweeper Watch App
//
//  Created by Jari Zilverentant on 30/12/2023.
//

import Foundation
import SwiftUI

struct ClickModeHandler: GameModeHandler {
    var gridViewModel: GridViewModel
    
    init(gridViewModel: GridViewModel) {
        self.gridViewModel = gridViewModel
    }
    
    func handleTapGesture(tap: CGPoint) {
        let tappedColumn = Int(tap.x / (TileView.tileSize + TileView.borderWidth))
        let tappedRow = Int(tap.y / (TileView.tileSize + TileView.borderWidth))
        gridViewModel.tappedTile(row: tappedRow, col: tappedColumn)
    }

    func handleLongPress(tap: CGPoint) {
        let tappedColumn = Int(tap.x / (TileView.tileSize + TileView.borderWidth))
        let tappedRow = Int(tap.y / (TileView.tileSize + TileView.borderWidth))
        gridViewModel.setTileFlag(row: tappedRow, col: tappedColumn)
    }

    func handleDigitalCrownRotation(gridView: GridView, value: Double) {
        // does absolutely nothing
    }
}
