//
//  GridView.swift
//  MiniMineSweeper Watch App
//
//  Created by Jari Zilverentant on 09/12/2023.
//
import SwiftUI

struct GridView: View {
    @ObservedObject private var gridViewModel = GridViewModel(rows: 8, columns: 8)
    @State private var up = false
    @State private var scrollAmount = 0.0
    @State private var prevScrollAmount = 0.0

    let scrollThreshold: Double = 10.0

    var body: some View {
        VStack(spacing: 2) {
            ForEach(0..<8) { row in
                HStack(spacing: 2) {
                    ForEach(0..<8) { col in
                        TileView(tileViewModel: TileViewModel(tileModel: gridViewModel.getTile(row: row, col: col)))
                    }
                }
            }
            .focusable(true)
            .digitalCrownRotation($scrollAmount)
            .onChange(of: scrollAmount) { value in
                let diff = value - prevScrollAmount

                if abs(diff) > scrollThreshold {
                    self.up = (diff > 0)
                    self.prevScrollAmount = value
                    self.gridViewModel.selectNextTile(up: self.up)
                }
            }
            .alignmentGuide(.top, computeValue: { _ in
                return -10
            })

            if(gridViewModel.gameState == GameState.lost) {
                Text("You have lost")
            } else if(gridViewModel.gameState == GameState.won) {
                Text("You have won")
            }
        }
        .onTapGesture {
            gridViewModel.discoverSelectedNeighbors()
        }
        .onLongPressGesture(minimumDuration: 0.3, perform: {
            switch(gridViewModel.gameState) {
            case .playing:
                gridViewModel.setSelectedFlag()
                break;
            case .won ,.lost:
                gridViewModel.restartGame()
                break;
            }
        } )
    }
}

struct GridView_Previews: PreviewProvider {
    static var previews: some View {
        GridView()
    }
}
