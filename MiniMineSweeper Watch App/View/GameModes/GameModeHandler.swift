//
//  GameModeHandler.swift
//  MiniMineSweeper Watch App
//
//  Created by Jari Zilverentant on 30/12/2023.
//

import Foundation
import SwiftUI

protocol GameModeHandler {
    func handleTapGesture(gridViewModel: GridViewModel, tap: CGPoint)
    func handleLongPress(gridViewModel: GridViewModel, tap: CGPoint)
    func handleDigitalCrownRotation(gridViewModel: GridViewModel, gridView: GridView, value: Double)
}
