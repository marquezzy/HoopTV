//
//  GameTableViewCell.swift
//  SportKit
//
//  Created by Marquez Gallegos on 1/29/18.
//  Copyright © 2018 Marquez Gallegos. All rights reserved.
//

import UIKit
import SDWebImage

public class GameTableViewCell : UITableViewCell {
    
    @IBOutlet var awayTeam: UILabel!
    @IBOutlet var homeTeam: UILabel!
    @IBOutlet var awayTeamLogo: UIImageView!
    @IBOutlet var homeTeamLogo: UIImageView!
    @IBOutlet var tvStations: UILabel!
    @IBOutlet var gameTime:UILabel!
    @IBOutlet var awayScore:UILabel!
    @IBOutlet var homeScore:UILabel!
    @IBOutlet var awayRank:UILabel!
    @IBOutlet var homeRank:UILabel!
    @IBOutlet var awayRecord:UILabel!
    @IBOutlet var homeRecord:UILabel!
    @IBOutlet var awayLayoutConstraint:NSLayoutConstraint!
    @IBOutlet var homeLayoutConstraint:NSLayoutConstraint!
    @IBOutlet var awayLogoLayoutConstraint:NSLayoutConstraint!
    @IBOutlet var homeLogoLayoutConstraint:NSLayoutConstraint!

    public func populate(gameViewModel:GameViewModel) {
        self.awayTeam.text = gameViewModel.awayTeam
        self.homeTeam.text = gameViewModel.homeTeam
        self.tvStations.text = gameViewModel.tvStations
        self.gameTime.text = gameViewModel.gameTime
        self.awayTeamLogo.sd_setImage(with: URL(string: gameViewModel.awayLogoURL), completed: nil)
        self.homeTeamLogo.sd_setImage(with: URL(string: gameViewModel.homeLogoURL), completed: nil)
        self.awayScore.text = gameViewModel.awayScore
        self.homeScore.text = gameViewModel.homeScore
        self.awayRecord.text = gameViewModel.awayRecord
        self.homeRecord.text = gameViewModel.homeRecord
        
        if let awayRank = gameViewModel.awayRank {
            self.awayRank.text = awayRank
            self.awayLayoutConstraint.constant = 4.0
            NSLayoutConstraint.deactivate([self.awayLogoLayoutConstraint])
        }
        else {
            self.awayRank.text = ""
            self.awayLayoutConstraint.constant = 0.0
            self.awayLogoLayoutConstraint.constant = 6.0
        }
        
        if let homeRank = gameViewModel.homeRank {
            self.homeRank.text = homeRank
            self.homeLayoutConstraint.constant = 4.0
            NSLayoutConstraint.deactivate([self.homeLogoLayoutConstraint])
        }
        else {
            self.homeRank.text = ""
            self.homeLayoutConstraint.constant = 0.0
            self.homeLogoLayoutConstraint.constant = 6.0
        }
    }
}
