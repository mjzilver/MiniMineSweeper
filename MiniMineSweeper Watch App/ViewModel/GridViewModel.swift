//
//  GridViewModel.swift
//  MiniMineSweeper Watch App
//
//  Created by Jari Zilverentant on 09/12/2023.
//

import Foundation
import Combine

class GridViewModel: ObservableObject {
    @Published var model: GridModel
    private var minePercentageStep = 0.05

    init(rows: Int, columns: Int) {
        self.model = GridModel(
            tiles: (0..<rows).map { row in (0..<columns).map { col in TileModel(x: col, y: row) } },
            totalColumns: columns,
            totalRows: rows,
            totalTiles: rows * columns,
            mineCount: Int(Double(rows * columns) * minePercentageStep)
        )

        setupBoard()
    }
    
    var gameState: GameState {
        model.gameState
    }

    public func getTile(row: Int, col: Int) -> TileModel {
        model.tiles[row][col]
    }

    public func restartGame(increaseMines: Bool = false) {
        if(increaseMines) {
            model.percentMines += minePercentageStep
        }

        for i in 0..<model.tiles.count {
            for j in 0..<model.tiles[i].count {
                model.tiles[i][j].reset()
            }
        }

        model.mineCount = Int(Double(model.totalTiles) * model.percentMines)
        setupMines()

        model.gameState = .playing
        objectWillChange.send()
    }

    public func setupBoard() {
        model.tiles = (0..<model.totalRows).map { row in (0..<model.totalColumns).map { col in TileModel(x: col, y: row) } }

        model.mineCount = Int(Double(model.totalTiles) * model.percentMines)

        setupMines()
    }

    public func revealAll() {
        for i in 0..<model.tiles.count {
            for j in 0..<model.tiles[i].count {
                model.tiles[i][j].revealTile()
            }
        }
    }

    public func setSelectedFlag() {
        let row = model.selectedTileIndex / model.totalColumns
        let col = model.selectedTileIndex % model.totalColumns
        model.tiles[row][col].toggleFlag()

        var foundMines = 0;

        model.mineIndices.forEach { index in
            let mineRow = index / model.totalColumns
            let mineCol = index % model.totalColumns

            if(model.tiles[mineRow][mineCol].isFlag) {
                foundMines += 1;
            }
        }

        if(foundMines == model.mineCount) {
            model.gameState = GameState.won
        }
        objectWillChange.send()
    }

    public func selectNextTile(up: Bool) {
        var row = model.selectedTileIndex / model.totalColumns
        var col = model.selectedTileIndex % model.totalColumns
        model.tiles[row][col].isSelected = false
        
        let nextIndex = up ? 1 : -1

        model.selectedTileIndex += nextIndex

        // Wrap around if below 0 or beyond the last tile
        if model.selectedTileIndex < 0 {
            model.selectedTileIndex = model.totalColumns * model.totalRows - 1
        } else if model.selectedTileIndex >= model.totalColumns * model.totalRows {
            model.selectedTileIndex = 0
        }

        row = model.selectedTileIndex / model.totalColumns
        col = model.selectedTileIndex % model.totalColumns

        model.tiles[row][col].isSelected = true
    }

    private func setupMines() {
        var minesPlaced = 0

        while minesPlaced < model.mineCount {
            let randomRow = Int.random(in: 0..<model.totalRows)
            let randomColumn = Int.random(in: 0..<model.totalColumns)
            let randomIndex = randomRow * model.totalColumns + randomColumn

            if !model.mineIndices.contains(randomIndex) {
                model.mineIndices.insert(randomIndex)
                model.tiles[randomRow][randomColumn].isMine = true
                minesPlaced += 1
            }
        }
    }

    public func discoverSelectedNeighbors() {
        let row = model.selectedTileIndex / model.totalColumns
        let col = model.selectedTileIndex % model.totalColumns
        
        if(model.tiles[row][col].isMine) {
            model.gameState = GameState.lost
            revealAll()
        } else {
            discoverNeighbors(row: row, col: col)
        }
        objectWillChange.send()
    }

    public func discoverNeighbors(row: Int, col: Int) {
        let clickedTile = model.tiles[row][col]

        // relative positions of neighbors (a 3x3 grid)
        let relativeRows = [-1, -1, -1, 0, 0, 1, 1, 1]
        let relativeCols = [-1, 0, 1, -1, 1, -1, 0, 1]

        clickedTile.revealTile()

        var bombCount = 0

        // Iterate through neighbors
        for i in 0..<relativeRows.count {
            let neighborRow = row + relativeRows[i]
            let neighborCol = col + relativeCols[i]

            if neighborRow >= 0 && neighborRow < model.tiles.count
                && neighborCol >= 0 && neighborCol < model.tiles[0].count {
                let neighbor = model.tiles[neighborRow][neighborCol]

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

                if neighborRow >= 0 && neighborRow < model.tiles.count
                    && neighborCol >= 0 && neighborCol < model.tiles[0].count {
                    let neighbor = model.tiles[neighborRow][neighborCol]

                    if !neighbor.isRevealed {
                        discoverNeighbors(row: neighbor.y, col: neighbor.x)
                    }
                }
            }
        }
    }
}
