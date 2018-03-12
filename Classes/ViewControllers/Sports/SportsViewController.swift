//
//  SportsViewController.swift
//  SportKit
//
//  Created by Marquez Gallegos on 1/25/18.
//  Copyright © 2018 Marquez Gallegos. All rights reserved.
//

import UIKit

public class SportsViewController : UIViewController {
    
    @IBOutlet var tableView:UITableView!
    var sports : [Sport] = []
    let cellIdentifier = String(describing: SportsTableViewCell.self)
    
    init() {
        super.init(nibName: String(describing: SportsViewController.self), bundle: nil)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override public func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        let nib = UINib(nibName: self.cellIdentifier, bundle: nil)
        self.tableView.register(nib, forCellReuseIdentifier: self.cellIdentifier)

        self.navigationItem.title = NSLocalizedString("Sports", comment: "")
        
        StartupValuesDataStore().getStartupValues { [weak self] (startupValues, error) in
            if let startupValues = startupValues {
                self?.tableView.beginUpdates()
                self?.sports = startupValues.sports.filter{$0.sportType == SportType.basketball}
                self?.tableView.insertSections(IndexSet([0]), with: .top)
                self?.tableView.endUpdates()
            }
        }
    }
}

extension SportsViewController : UITableViewDelegate {
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let sport = self.sports[indexPath.row]
        let gamesViewController = GamesViewController(sport: sport)
        self.navigationController?.pushViewController(gamesViewController, animated: true)
        self.tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension SportsViewController : UITableViewDataSource {
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: self.cellIdentifier) as? SportsTableViewCell else {
            return UITableViewCell()
        }
        
        cell.sportName.text = self.sports[indexPath.row].displayName
        
        return cell
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.sports.count
    }

    public func numberOfSections(in tableView: UITableView) -> Int {
        return self.sports.count > 0 ? 1 : 0
    }
}
