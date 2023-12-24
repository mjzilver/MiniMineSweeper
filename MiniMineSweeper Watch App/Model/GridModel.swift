//
//  GridModel.swift
//  MiniMineSweeper Watch App
//
//  Created by Jari Zilverentant on 24/12/2023.
//

import Foundation

class GridModel: ObservableObject {
    @Published var tiles: [[TileModel]]
    @Published var selectedTileIndex: Int
    @Published var gameState: GameState
    var totalColumns: Int
    var totalRows: Int
    var totalTiles: Int
    var mineCount: Int
    var mineIndices: Set<Int>
    var percentMines: Double
        
    init(tiles: [[TileModel]], selectedTileIndex: Int = 0, gameState: GameState = .playing, totalColumns: Int, totalRows: Int, totalTiles: Int, mineCount: Int, mineIndices: Set<Int> = Set<Int>(), percentMines: Double = 0.1) {
        self.tiles = tiles
        self.selectedTileIndex = selectedTileIndex
        self.gameState = gameState
        self.totalColumns = totalColumns
        self.totalRows = totalRows
        self.totalTiles = totalTiles
        self.mineCount = mineCount
        self.mineIndices = mineIndices
        self.percentMines = percentMines
    }
}
