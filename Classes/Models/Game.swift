//
//  Game.swift
//  SportKit
//
//  Created by Marquez Gallegos on 1/25/18.
//  Copyright © 2018 Marquez Gallegos. All rights reserved.
//

import Foundation

enum GameStatus : String, Codable {
    case scheduled = "SCHEDULED"
    case started = "STARTED"
    case final = "FINAL"
}

public struct Game : Codable {
    
    let gameId : String
    let venue : String
    let gameStatus : GameStatus
    let awayTeamId : String
    let awayTeam : String
    let homeTeamId : String
    let homeTeam : String
    let awayWins : Int
    let awayLosses : Int
    let homeWins : Int
    let homeLosses : Int
    let startTime : Date
    var homeScore : Int?
    var awayScore : Int?
    var awayRank : String?
    var homeRank : String?
    var timeRemainingFrac : Int?
    var tvStations : String?
    var quarter : String?
    
    enum CodingKeys : String, CodingKey {
        case gameId = "GameId"
        case venue = "Venue"
        case gameStatus = "GameStatus"
        case awayTeamId = "AwayTeamID"
        case awayTeam = "AwayTeam"
        case homeTeamId = "HomeTeamID"
        case homeTeam = "HomeTeam"
        case startTime = "StartTime"
        case awayScore = "AwayScore"
        case homeScore = "HomeScore"
        case timeRemainingFrac = "TimeRemainingFrac"
        case tvStations = "TvStations"
        case quarter = "Quarter"
        case awayRank = "AwayRank"
        case homeRank = "HomeRank"
        case awayWins = "AwayWins"
        case awayLosses = "AwayLosses"
        case homeWins = "HomeWins"
        case homeLosses = "HomeLosses"
    }
    
    public var awayLogoURL : String {
        return "\(SportConfigurationManager.defaultConfiguration().baseURL)/team/\(self.awayTeamId)/yslogo/40/40?forWhiteBG=true"
    }

    public var homeLogoURL : String {
        return "\(SportConfigurationManager.defaultConfiguration().baseURL)/team/\(self.homeTeamId)/yslogo/40/40?forWhiteBG=true"
    }
}

