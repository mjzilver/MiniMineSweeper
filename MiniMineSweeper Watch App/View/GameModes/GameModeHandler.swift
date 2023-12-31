//
//  GameModeHandler.swift
//  MiniMineSweeper Watch App
//
//  Created by Jari Zilverentant on 30/12/2023.
//

import Foundation
import SwiftUI

protocol GameModeHandler {
    var gridViewModel: GridViewModel { get set }
    
    init(gridViewModel: GridViewModel)
    
    func handleTapGesture(tap: CGPoint)
    func handleLongPress(tap: CGPoint)
    func handleDigitalCrownRotation(gridView: GridView, value: Double)
}
