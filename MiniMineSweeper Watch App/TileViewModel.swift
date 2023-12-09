//
//  TileViewModel.swift
//  MiniMineSweeper Watch App
//
//  Created by Jari Zilverentant on 09/12/2023.
//

import Foundation

class TileViewModel: ObservableObject {
    @Published var isMine: Bool
    @Published var isRevealed: Bool
    @Published var number: Int
    @Published var isSelected: Bool
    @Published var isFlag: Bool
    public var x, y: Int
    
    init(y: Int, x: Int) {
        isMine = false
        isRevealed = false
        isSelected = false
        isFlag = false
        number = 0
        self.x = x
        self.y = y
    }
    
    public func toggleFlag() {
        isFlag = !isFlag
    }
    
    public func revealTile() {
        isRevealed = true
    }
}
