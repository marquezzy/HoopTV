//
//  Sport.swift
//  SportKit
//
//  Created by Marquez Gallegos on 1/25/18.
//  Copyright © 2018 Marquez Gallegos. All rights reserved.
//

import Foundation

enum SportType : String, Codable {
    case basketball = "BASKETBALL"
    case football = "FOOTBALL"
    case baseball = "BASEBALL"
    case hockey = "HOCKEY"
    case soccer = "SOCCER"
    case tennis = "TENNIS"
    case golf = "GOLF"
    case racing = "RACING"
    case other = "OTHER"
}

class GameScheduleBits : Codable {
    
    let timezone : String
    let minDateString : String
    let maxDateString : String
    let bits : String
    
    enum CodingKeys : String, CodingKey {
        case timezone = "Timezone"
        case minDateString = "MinDate"
        case maxDateString = "MaxDate"
        case bits = "Bits"
    }
    
    var minDate : Date? {
        return DateFormatter.scheduleBitFormatter.date(from: self.minDateString)
    }
    
    var maxDate : Date? {
        return DateFormatter.scheduleBitFormatter.date(from: self.maxDateString)
    }
}

extension DateFormatter {
    fileprivate static let scheduleBitFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        formatter.locale = Locale(identifier: "yyyy-MM-dd")
        formatter.timeZone = TimeZone.current
        return formatter
    }()
}

struct CollegeConferences : Codable {
    
    let abbrev: String
    let name: String
    let confId: String
    let context: String
    var isPrimary: Bool?
    
    enum CodingKeys : String, CodingKey {
        case abbrev = "Abbrev"
        case name = "Name"
        case confId = "ConfId"
        case context = "Context"
        case isPrimary = "IsPrimary"
    }
}

struct CollegeSportsOptions : Codable {
    
    let defaultConferences: [CollegeConferences]
    let defaultConferencesUpdated : Date
    
    enum CodingKeys : String, CodingKey {
        case defaultConferences = "DefaultConferences"
        case defaultConferencesUpdated = "DefaultConferenceUpdated"
    }
}

public struct Sport : Codable {
    
    let nameModern : String
    let displayName : String
    let sortPriority : Float
    let sportType : SportType
    var minDate : Date?
    var maxDate : Date?
    var preSeasonStartDate : Date?
    var preSeasonEndDate : Date?
    var regularSeasonStartDate : Date?
    var regularSeasonEndDate : Date?
    var gameScheduleBits : GameScheduleBits?
    var collegeSportOptions : CollegeSportsOptions?
    
    enum CodingKeys : String, CodingKey {
        case nameModern = "NameModern"
        case displayName = "DisplayName"
        case sportType = "SportType"
        case sortPriority = "SortPriority"
        case minDate = "MinDate"
        case maxDate = "MaxDate"
        case preSeasonStartDate = "PreSeasonStartDate"
        case preSeasonEndDate = "PreSeasonEndDate"
        case regularSeasonStartDate = "RegularSeasonStartDate"
        case regularSeasonEndDate = "RegularSeasonEndDate"
        case gameScheduleBits = "GameScheduleBits"
        case collegeSportOptions = "CollegeSportOptions"
    }
}
