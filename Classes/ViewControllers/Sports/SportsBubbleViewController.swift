//
//  SportsBubbleViewController.swift
//  HoopTV
//
//  Created by Marquez Gallegos on 3/11/18.
//  Copyright © 2018 Marquez Gallegos. All rights reserved.
//

import Foundation
import UIKit
import Magnetic

public class SportsBubbleViewController : UIViewController {
    
    var sports : [Sport] = []
    var magnetic : Magnetic?
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override public func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.navigationItem.title = NSLocalizedString("Sports", comment: "")
        
        let magneticView = MagneticView(frame: self.view.bounds)
        self.magnetic = magneticView.magnetic
        self.magnetic?.magneticDelegate = self
        self.view.addSubview(magneticView)
        
        StartupValuesDataStore().getStartupValues { [weak self] (startupValues, error) in
            if let startupValues = startupValues {
                self?.sports = startupValues.sports.filter{$0.sportType == SportType.basketball}
                for sport in (self?.sports)! {
                    self?.magnetic?.addChild(SportNode(sport: sport))
                }
            }
        }
    }
}

extension SportsBubbleViewController : MagneticDelegate {
    public func magnetic(_ magnetic: Magnetic, didDeselect node: Node) {
        let sportNode : SportNode = node as! SportNode
        let sport = sportNode.sport
        print("Deselect: \(sport.displayName)")
    }
    
    public func magnetic(_ magnetic: Magnetic, didSelect node: Node) {
        let sportNode : SportNode = node as! SportNode
        let sport = sportNode.sport
        let gamesViewController = GamesViewController(sport: sport)
        self.navigationController?.pushViewController(gamesViewController, animated: true)
    }
}

class SportNode : Node {
    let sport : Sport
    init(sport:Sport) {
        self.sport = sport
        super.init(text: sport.displayName, image: nil, color: UIColor.orange, radius: 60.0)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
