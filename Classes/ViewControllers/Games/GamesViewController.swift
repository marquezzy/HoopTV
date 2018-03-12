//
//  GamesViewController.swift
//  SportKit
//
//  Created by Marquez Gallegos on 1/26/18.
//  Copyright © 2018 Marquez Gallegos. All rights reserved.
//

import UIKit

public class GamesViewController : UIViewController {
    
    // required on creation
    let sport : Sport
    let dataSource : GamesTableViewDataSource
    let gameDataStore : GamesDataStore
    
    // table view & identifiers
    @IBOutlet public var tableView:UITableView!
    let gameHeaderViewIdentifier = String(describing: GamesHeaderView.self)
    let cellIdentifier =  String(describing: GameTableViewCell.self)

    // state
    var lastDateLoaded:Date?
    var keepLoadingGames:Bool = true
    
    // approximate number of games that fill up a single phone screen
    let approximatePageSize = 12
    
    init(sport:Sport) {
        self.sport = sport
        self.dataSource = GamesTableViewDataSource()
        self.gameDataStore = GamesDataStore(sport: sport)
        super.init(nibName: String(describing: GamesViewController.self), bundle: nil)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override public func viewDidLoad() {
        
        super.viewDidLoad()
        
        // set up tableview
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        let nib = UINib(nibName: self.cellIdentifier, bundle: nil)
        let headerNib = UINib(nibName: self.gameHeaderViewIdentifier, bundle: nil)
        self.tableView.register(nib, forCellReuseIdentifier: self.cellIdentifier)
        self.tableView.register(headerNib, forHeaderFooterViewReuseIdentifier: self.gameHeaderViewIdentifier)
        
        // set up nav bar
        self.navigationItem.title = self.sport.displayName
        
        // load data
        self.loadGames(startDate: Date())
    }
    
    private func loadGames ( startDate:Date ) {
        
        guard self.hasGameForDate(date: startDate) else {
            return
        }
        
        // init datetime range and save the end date
        let startDate = Calendar.current.startOfDay(for: startDate)
        var components = DateComponents()
        components.day = 1
        let endDate = Calendar.current.date(byAdding: components, to: startDate)!
        self.lastDateLoaded = endDate
        
        self.gameDataStore.getGames(sport:self.sport, startDate: startDate, endDate:endDate) { [weak self] (games, error) in
            
            guard let strongSelf = self else { return }

            if let games = games, games.count > 0 {
                let tvGames = games.filter{$0.tvStations != nil}.map{GameViewModel(game:$0)}
                if tvGames.count > 0 {
                    
                    // peak at the first game to get the game date
                    let game = games.first
                    let sectionDate = Calendar.current.startOfDay(for: game!.startTime)
                    
                    // update tableview & data source
                    strongSelf.tableView.beginUpdates()
                    let index = strongSelf.dataSource.insertGames(date: sectionDate, games: tvGames)
                    strongSelf.tableView.insertSections(IndexSet([index]), with: .top)
                    strongSelf.tableView.endUpdates()
                }
            }
            
            if strongSelf.dataSource.count < strongSelf.approximatePageSize {
                strongSelf.loadGames(startDate: endDate)
            }
        }
    }
    
    private func hasGameForDate(date:Date) -> Bool {
        return self.gameDataStore.hasGameForDate(date: date)
    }
}

extension GamesViewController : UITableViewDelegate {
    
    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        let actualPosition = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height - (scrollView.frame.size.height)
        
        // this delegate method is being called at load for some reason with 0 content height.
        // added a check that we have a valid content height before loading the next page.
        if contentHeight > 0 && actualPosition >= (contentHeight - 82.0) {
            if let lastDate = self.lastDateLoaded {
                self.loadGames(startDate: lastDate)
            }
        }
    }
}

extension GamesViewController : UITableViewDataSource {
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: self.cellIdentifier) as? GameTableViewCell else {
            return UITableViewCell()
        }
        
        cell.populate(gameViewModel: self.dataSource.gameForIndexPath(indexPath: indexPath))
        
        return cell
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataSource.numberOfRowsInSection(section: section)
    }
    
    public func numberOfSections(in tableView: UITableView) -> Int {
        return self.dataSource.numberOfSections()
    }
    
    public func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        if let gamesHeaderView = tableView.dequeueReusableHeaderFooterView(withIdentifier: self.gameHeaderViewIdentifier) as? GamesHeaderView {
            gamesHeaderView.populate(date: self.dataSource.dateForSection(section: section))
            return gamesHeaderView
        }
        
        return nil
    }
}
