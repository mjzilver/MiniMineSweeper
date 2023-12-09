//
//  GridViewModel.swift
//  MiniMineSweeper Watch App
//
//  Created by Jari Zilverentant on 09/12/2023.
//

import Foundation
import SwiftUI
import Combine

class GridViewModel: ObservableObject {
    @Published var tiles: [[TileViewModel]] = []
    @Published var selectedTileIndex = 0
    @Published var gameText = ""
    private var totalColumns = 8
    private var totalRows = 8
    let totalTiles: Int
    let mineCount: Int
    private var mineIndices = Set<Int>()
    @Published var gameState = GameState.playing

    init(rows: Int, columns: Int) {
        tiles = (0..<rows).map { row in (0..<columns).map { col in TileViewModel(y: row, x: col) } }
        
        totalTiles = totalRows * totalColumns
        mineCount = Int(Double(totalTiles) * 0.1)
        
        setupMines()
    }
    
    public func setSelectedFlag() {
        let row = selectedTileIndex / totalColumns
        let col = selectedTileIndex % totalColumns
        tiles[row][col].toggleFlag()
        
        var foundMines = 0;
        
        mineIndices.forEach { index in
            let mineRow = index / totalColumns
            let mineCol = index % totalColumns
            
            if(tiles[mineRow][mineCol].isFlag) {
                foundMines += 1;
            }
        }
        
        if(foundMines == mineCount) {
            gameState = GameState.won
        }
    }
    
    public func selectNextTile(up: Bool) {
        var row = selectedTileIndex / totalColumns
        var col = selectedTileIndex % totalColumns
        tiles[row][col].isSelected = false

        let nextIndex = up ? 1 : -1
        
        selectedTileIndex += nextIndex
        
        // Wrap around if below 0 or beyond the last tile
        if selectedTileIndex < 0 {
            selectedTileIndex = totalColumns * totalRows - 1
        } else if selectedTileIndex >= totalColumns * totalRows {
            selectedTileIndex = 0
        }
        
        row = selectedTileIndex / totalColumns
        col = selectedTileIndex % totalColumns
        
        tiles[row][col].isSelected = true
    }

    private func setupMines() {
        var minesPlaced = 0

        while minesPlaced < mineCount {
            let randomRow = Int.random(in: 0..<totalRows)
            let randomColumn = Int.random(in: 0..<totalColumns)
            let randomIndex = randomRow * totalColumns + randomColumn

            if !mineIndices.contains(randomIndex) {
                mineIndices.insert(randomIndex)
                tiles[randomRow][randomColumn].isMine = true
                minesPlaced += 1
            }
        }
    }
    
    public func discoverSelectedNeighbors() {
        let row = selectedTileIndex / totalColumns
        let col = selectedTileIndex % totalColumns
        
        if(tiles[row][col].isMine) {
            gameState = GameState.lost
        } else {
            self.discoverNeighbors(row: row, col: col)
        }
    }
    
    public func discoverNeighbors(row: Int, col: Int) {
        let clickedTile = tiles[row][col]
        
        // Define the relative positions of neighbors (a 3x3 grid)
        let relativeRows = [-1, -1, -1, 0, 0, 1, 1, 1]
        let relativeCols = [-1, 0, 1, -1, 1, -1, 0, 1]
        
        clickedTile.revealTile()
        
        var bombCount = 0
        
        // Iterate through neighbors
        for i in 0..<relativeRows.count {
            let neighborRow = row + relativeRows[i]
            let neighborCol = col + relativeCols[i]
            
            if neighborRow >= 0 && neighborRow < tiles.count
                && neighborCol >= 0 && neighborCol < tiles[0].count {
                let neighbor = tiles[neighborRow][neighborCol]
                
                if neighbor.isMine {
                    bombCount += 1
                }
            }
        }
        
        // Update the clicked tile with the bomb count
        if bombCount > 0 {
            clickedTile.number = bombCount
        }
        
        // If the bomb count is zero, recursively discover neighbors
        if bombCount == 0 {
            for i in 0..<relativeRows.count {
                let neighborRow = row + relativeRows[i]
                let neighborCol = col + relativeCols[i]
                
                if neighborRow >= 0 && neighborRow < tiles.count
                    && neighborCol >= 0 && neighborCol < tiles[0].count {
                    let neighbor = tiles[neighborRow][neighborCol]
                    
                    if !neighbor.isRevealed {
                        discoverNeighbors(row: neighbor.y, col: neighbor.x)
                    }
                }
            }
        }
    }
}
