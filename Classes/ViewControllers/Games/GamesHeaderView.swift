//
//  GamesHeaderView.swift
//  HoopTV
//
//  Created by Marquez Gallegos on 1/31/18.
//  Copyright © 2018 Marquez Gallegos. All rights reserved.
//

import UIKit

public class GamesHeaderView : UITableViewHeaderFooterView {
    
    @IBOutlet weak var titleLabel: UILabel!
    
    public func populate(date:Date) {
        self.titleLabel.text = date.gameHeaderDateString()
    }
}

extension Date {
    fileprivate func gameHeaderDateString() -> String {
        return DateFormatter.gameDateFormatter.string(from: self as Date)
    }
}

extension DateFormatter {
    fileprivate static let gameDateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE, MMMM d"
        return formatter
    }()
}
