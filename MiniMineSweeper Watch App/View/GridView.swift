//
//  GridView.swift
//  MiniMineSweeper Watch App
//
//  Created by Jari Zilverentant on 09/12/2023.
//
import SwiftUI

struct GridView: View {
    @ObservedObject private var gridViewModel: GridViewModel
    @ObservedObject private var settingsViewModel: SettingsViewModel
    @State public var up = false
    @State public var scrollAmount = 0.0
    @State public var prevScrollAmount = 0.0
    @State private var showingSettings = false
    @State private var gameModeHandler: GameModeHandler?
    
    static let scrollThreshold: Double = 10.0
    
    init() {
        let settingsVM = SettingsViewModel()
        gridViewModel = GridViewModel(rows: 8, columns: 8, settingsViewModel: settingsVM)
        settingsViewModel = settingsVM

    }

    var body: some View {
        VStack(spacing: 2) {
            ForEach(0..<8) { row in
                HStack(spacing: 2) {
                    ForEach(0..<8) { col in
                        if let tile = gridViewModel.getTileAt(row: row, col: col) {
                            TileView(tileViewModel: TileViewModel(tileModel: tile))
                        }
                    }
                }
            }
            .onAppear {
                self.gameModeHandler = createGameModeHandler(for: settingsViewModel.gameMode)
            }
            .focusable(true)
            .digitalCrownRotation($scrollAmount)
            .onChange(of: scrollAmount) { value in
                gameModeHandler?.handleDigitalCrownRotation(gridView: self, value: value)
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
        .onTapGesture { tapPoint in
            gameModeHandler?.handleTapGesture(tap: tapPoint)
        }
        .gesture(LongPressGesture(minimumDuration: 0.3)
            .sequenced(before: DragGesture(minimumDistance: 0.0)
            .onEnded { value in
                switch gridViewModel.gameState {
                case .playing:
                    gameModeHandler?.handleLongPress(tap: value.location)
                case .won, .lost:
                    gridViewModel.restartGame()
                }
            }
        ))
        .gesture(swipeUpGesture)
        .sheet(isPresented: $showingSettings) {
            SettingsView(gridViewModel: gridViewModel, showingSettings: $showingSettings)
                .onChange(of: settingsViewModel.gameMode) { newGameMode in
                    gameModeHandler = createGameModeHandler(for: newGameMode)
                }
        }
    }
    
    private func createGameModeHandler(for gameMode: GameMode) -> GameModeHandler {
        switch gameMode {
        case .crown:
            gridViewModel.displaySelectTile(display: true)
            return CrownModeHandler(gridViewModel: gridViewModel)
        case .click:
            gridViewModel.displaySelectTile(display: false)
            return ClickModeHandler(gridViewModel: gridViewModel)
        }
    }
    
    private var swipeUpGesture: some Gesture {
        DragGesture()
            .onEnded { gesture in
                if gesture.translation.height < -50 {
                    showingSettings.toggle()
                }
            }
    }
}

struct GridView_Previews: PreviewProvider {
    static var previews: some View {
        GridView()
    }
}
