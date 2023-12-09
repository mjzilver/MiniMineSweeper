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
                        .fill(Color.red)
                } else if tileViewModel.number > 0 {
                    Rectangle()
                        .fill(Color.purple)
                        .overlay(
                            Text("\(tileViewModel.number)")
                                .foregroundColor(.white)
                        )
                } else {
                    Rectangle()
                        .fill(Color.green)
                }
            } else {
                Rectangle()
                    .fill(Color.gray)
            }
        }
        .frame(width: 22, height: 22)
    }
}
