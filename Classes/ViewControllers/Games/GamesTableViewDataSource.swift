//
//  GamesDataSource.swift
//  HoopTV
//
//  Created by Marquez Gallegos on 1/31/18.
//  Copyright © 2018 Marquez Gallegos. All rights reserved.
//

import Foundation

struct DataSection {
    let date:Date
    var games:[GameViewModel]
}

extension DataSection: Comparable {
    static func <(lhs: DataSection, rhs: DataSection) -> Bool {
        return lhs.date < rhs.date
    }
    
    static func ==(lhs: DataSection, rhs: DataSection) -> Bool {
        return lhs.date == rhs.date
    }
}
    
class GamesTableViewDataSource {
    
    private var sortedData : SortedArray<DataSection> = SortedArray(sorted: [])
    public var count : Int = 0
    
    public func insertGames(date:Date, games:[GameViewModel]) -> Int {
        self.count = self.count + games.count
        return self.sortedData.insert(DataSection(date:date, games:games))
    }
    
    public func dateForSection(section:Int) -> Date {
        return self.sortedData[section].date
    }
    
    public func numberOfSections() -> Int {
        return self.sortedData.count
    }
    
    public func numberOfRowsInSection(section:Int) -> Int {
        let dataSection = self.sortedData[section]
        return dataSection.games.count
    }
    
    public func gameForIndexPath(indexPath:IndexPath) -> GameViewModel {
        return self.sortedData[indexPath.section].games[indexPath.row]
    }
}
