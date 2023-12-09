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
    @Published var gameText = ""

    init(rows: Int, columns: Int) {
        tiles = (0..<rows).map { row in (0..<columns).map { col in TileViewModel(y: row, x: col) } }
        setupMines()
    }

    private func setupMines() {
        let totalRows = tiles.count
        let totalColumns = tiles.first?.count ?? 0
        let totalTiles = totalRows * totalColumns
        let mineCount = Int(Double(totalTiles) * 0.1)

        var minesPlaced = 0
        var mineIndices = Set<Int>()

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
