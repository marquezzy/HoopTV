//
//  GamesDataStore.swift
//  SportKit
//
//  Created by Marquez Gallegos on 1/25/18.
//  Copyright © 2018 Marquez Gallegos. All rights reserved.
//

import Foundation

public class GamesDataStore : DataStore {

    let sport : Sport
    
    init(sport:Sport) {
        self.sport = sport
        super.init()
    }
    
    public func getGames ( sport:Sport, startDate:Date, endDate:Date, completion: @escaping ([Game]?, Error? ) -> Void) {
        
        let operation = "sport/\(sport.nameModern)/games"
        let parameters = ["startDate": startDate.gameDateString(), "endDate": endDate.gameDateString()]
        
        self.getData(type: [Game].self, operation: operation, parameters: parameters, completion: completion)
    }
    
    public func hasGameForDate(date:Date) -> Bool {
        
        // check input, if no valid gameScheduleBits object (with minDate and maxDate set) return true to let client check itself
        guard let scheduleBits = self.sport.gameScheduleBits, let minDate = scheduleBits.minDate, let maxDate = scheduleBits.maxDate else {
            return true
        }
        
        // check that input date lies within minDate and maxDate
        let minDateInterval = minDate.timeIntervalSince1970
        let maxDateInterval = maxDate.timeIntervalSince1970
        let inDateInterval = date.timeIntervalSince1970
        if inDateInterval < minDateInterval || inDateInterval > maxDateInterval {
            return false
        }

        // get base bitmask size
        let bitCount = MemoryLayout<Int64>.size * 8
        
        // get 64-bit values
        let bitStrings = scheduleBits.bits.split(separator: ",")
        let bitValues = bitStrings.map { Int64($0) }
        
        let calendarComponents = Calendar.calendar.dateComponents([Calendar.Component.day], from: minDate, to: maxDate)
        
        guard let day = calendarComponents.day else { return false }
        
        // one more check to ensure we have a bit mask for this date
        let scheduleOffset = Int(floor(Float(day) / Float(bitCount)))
        if scheduleOffset >= bitValues.count {
            return false
        }
        
        guard let scheduleBitMask = bitValues[scheduleOffset] else { return false }
        
        // now check the bit mask
        let days = Int64(day) - Int64(bitCount) * Int64(scheduleOffset)
        let maskedDate = 1 << (days - 0);
        let activeBit = (maskedDate & scheduleBitMask);
        return (activeBit == maskedDate);
    }
}

extension Calendar {
    fileprivate static let calendar : Calendar = {
        let calendar = Calendar.current
        return calendar
    }()
}

extension Date {
    fileprivate func gameDateString() -> String {
        return DateFormatter.gameDateFormatter.string(from: self as Date)
    }
}

extension DateFormatter {

    fileprivate static let gameDateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss Z"
        formatter.locale = Locale(identifier: "yyyy-MM-dd'T'HH:mm:ss Z")
        formatter.timeZone = TimeZone.current
        return formatter
    }()
}
