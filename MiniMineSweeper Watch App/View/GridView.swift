//
//  GridView.swift
//  MiniMineSweeper Watch App
//
//  Created by Jari Zilverentant on 09/12/2023.
//
import SwiftUI

struct GridView: View {
    @StateObject private var gridViewModel = GridViewModel(rows: 8, columns: 8)

    var body: some View {
        VStack(spacing: 2) {
            ForEach(0..<8) { row in
                HStack(spacing: 2) {
                    ForEach(0..<8) { col in
                        TileView(tileViewModel: gridViewModel.tiles[row][col])
                        .onTapGesture {
                            print("lets find em")
                            gridViewModel.discoverNeighbors(row: row, col: col)
                        }
                    }
                }
            }
            if(gridViewModel.gameText != "") {
                Text(gridViewModel.gameText)
            }
        }
    }
}
