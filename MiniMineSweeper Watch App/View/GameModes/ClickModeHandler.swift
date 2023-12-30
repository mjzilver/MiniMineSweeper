//
//  ClickModeHandler.swift
//  MiniMineSweeper Watch App
//
//  Created by Jari Zilverentant on 30/12/2023.
//

import Foundation
import SwiftUI

struct ClickModeHandler: GameModeHandler {
    func handleTapGesture(gridViewModel: GridViewModel, tap: CGPoint) {
        let tappedColumn = Int(tap.x / (TileView.tileSize + TileView.borderWidth))
        let tappedRow = Int(tap.y / (TileView.tileSize + TileView.borderWidth))
        gridViewModel.tappedTile(row: tappedRow, col: tappedColumn)
    }

    func handleLongPress(gridViewModel: GridViewModel, tap: CGPoint) {
        let tappedColumn = Int(tap.x / (TileView.tileSize + TileView.borderWidth))
        let tappedRow = Int(tap.y / (TileView.tileSize + TileView.borderWidth))
        gridViewModel.setTileFlag(row: tappedRow, col: tappedColumn)
    }

    func handleDigitalCrownRotation(gridViewModel: GridViewModel, gridView: GridView, value: Double) {
        // does absolutely nothing
    }
}
