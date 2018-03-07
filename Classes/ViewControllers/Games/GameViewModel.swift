//
//  GameViewModel.swift
//  SportKit
//
//  Created by Marquez Gallegos on 1/29/18.
//  Copyright © 2018 Marquez Gallegos. All rights reserved.
//

import Foundation

public struct GameViewModel {
    
    let awayTeam : String
    let homeTeam : String
    let awayLogoURL : String
    let homeLogoURL : String
    let gameTime : String
    let tvStations : String
    let awayRank : String?
    let homeRank : String?
    var awayScore : String = ""
    var homeScore : String = ""
    var awayRecord : String = ""
    var homeRecord : String = ""
    init(game:Game) {
        self.awayTeam = game.awayTeam
        self.homeTeam = game.homeTeam
        if let tvStations = game.tvStations {
            
            self.tvStations = tvStations
        }
        else {
            self.tvStations = ""
        }
        if let gameTimeString = game.quarter, game.gameStatus != GameStatus.scheduled {
            self.gameTime = gameTimeString
        }
        else {
            self.gameTime = game.startTime.gameTimeString()
        }
        self.awayLogoURL = game.awayLogoURL
        self.homeLogoURL = game.homeLogoURL
        self.awayRank = game.awayRank
        self.homeRank = game.homeRank
        if let awayScore = game.awayScore, let homeScore = game.homeScore, game.gameStatus != GameStatus.scheduled {
            self.awayScore = "\(awayScore)"
            self.homeScore = "\(homeScore)"
        }
        
        if game.gameStatus == GameStatus.scheduled {
            self.awayRecord = "\(game.awayWins)-\(game.awayLosses)"
            self.homeRecord = "\(game.homeWins)-\(game.homeLosses)"
        }
    }
}

extension Date {
    fileprivate func gameTimeString() -> String {
        return DateFormatter.gameTimeFormatter.string(from: self as Date)
    }
}

extension DateFormatter {
    fileprivate static let gameTimeFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "h:mm a"
        return formatter
    }()
}
