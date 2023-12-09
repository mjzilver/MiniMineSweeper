//
//  TileView.swift
//  MiniMineSweeper Watch App
//
//  Created by Jari Zilverentant on 09/12/2023.
//

import Foundation
import SwiftUI

struct TileView: View {
    @StateObject var tileViewModel: TileViewModel

    var body: some View {
        Group {
            if tileViewModel.isRevealed {
                if tileViewModel.isMine {
                    Rectangle()
                        .fill(Color.black)
                        .overlay(borderOverlay)
                } else if tileViewModel.number > 0 {
                    Rectangle()
                        .fill(Color.purple)
                        .overlay(
                            Text("\(tileViewModel.number)")
                                .foregroundColor(.white)
                        )
                        .overlay(borderOverlay)
                } else {
                    Rectangle()
                        .fill(Color.green)
                        .overlay(borderOverlay)
                }
            } else {
                if tileViewModel.isFlag {
                    Rectangle()
                        .fill(Color.red)
                        .overlay(borderOverlay)
                } else {
                    Rectangle()
                        .fill(Color.gray)
                        .overlay(borderOverlay)
                }
            }
        }
        .frame(width: 22, height: 22)
    }

    private var borderOverlay: some View {
        RoundedRectangle(cornerRadius: 4)
            .stroke(tileViewModel.isSelected ? Color.yellow : Color.clear, lineWidth: tileViewModel.isSelected ? 2 : 0)
    }
}
