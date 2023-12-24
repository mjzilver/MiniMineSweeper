//
//  TileModel.swift
//  MiniMineSweeper Watch App
//
//  Created by Jari Zilverentant on 24/12/2023.
//

import Foundation

class TileModel: ObservableObject {
    @Published var isMine: Bool
    @Published var isRevealed: Bool
    @Published var isFlag: Bool
    @Published var isSelected: Bool
    @Published var number: Int
    @Published var x: Int
    @Published var y: Int
    
    init(isMine: Bool = false, isRevealed: Bool = false, number: Int = 0, isFlag: Bool = false, x: Int, y: Int, isSelected: Bool = false) {
        self.isMine = isMine
        self.isRevealed = isRevealed
        self.number = number
        self.isFlag = isFlag
        self.x = x
        self.y = y
        self.isSelected = isSelected
    }

    public func reset() {
        isMine = false
        isRevealed = false
        isFlag = false
        number = 0
    }

    public func toggleFlag() {
        if !isRevealed {
            isFlag.toggle()
        }
    }

    public func revealTile() {
        isRevealed = true
        isFlag = false
    }
}
