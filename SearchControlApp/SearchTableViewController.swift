//
//  SearchTableViewController.swift
//  SearchControlApp
//
//  Created by Fethi El Hassasna on 7/25/15.
//  Copyright (c) 2015 Fethi El Hassasna. All rights reserved.
//

import UIKit

class SearchTableViewController: UITableViewController, UISearchResultsUpdating {
    
    let teams = ["Arsenal", "Chelsea", "Everton", "Liverpool", "Manchester City", "Manchester United", "Newcastle", "Spurs", "Swansea"]
    var filtredTeams = [String]()
    var resultSeachController = UISearchController()

    override func viewDidLoad() {
        super.viewDidLoad()

        // initiate the SeachController with an empty UISearchController
        self.resultSeachController = UISearchController(searchResultsController: nil)
        
        self.resultSeachController.searchResultsUpdater = self
        self.resultSeachController.dimsBackgroundDuringPresentation = false
        self.resultSeachController.searchBar.sizeToFit()
        
        self.title = "BPL Teams"
        
        self.tableView.tableHeaderView = self.resultSeachController.searchBar
        
        self.tableView.reloadData()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        // Test if resultSeachController is active to return filtred array count
        
        if self.resultSeachController.active {
            return self.filtredTeams.count
        } else {
            return self.teams.count
        }
        
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! UITableViewCell

        // Test if resultSeachController is active to display the filtred array Strings
        
        if self.resultSeachController.active {
            cell.textLabel?.text = self.filtredTeams[indexPath.row]
        } else {
            cell.textLabel?.text = self.teams[indexPath.row]
        }
        
        return cell
    }
    
    // MARK: - UISearchResultsUpdating
    
    func updateSearchResultsForSearchController(searchController: UISearchController) {
        
        // Remove all filtredTeams items
        self.filtredTeams.removeAll(keepCapacity: false)
        
        // Create a Predicate
        let searchPredicate = NSPredicate(format: "SELF CONTAINS[c] %@", searchController.searchBar.text)
        
        // Create NSArray (this array represent SELF in the Predicate above)
        let array = (self.teams as NSArray).filteredArrayUsingPredicate(searchPredicate)
        
        // New filtredTeams from the array result
        self.filtredTeams = array as! [String]
        
        // Reload TableView data
        self.tableView.reloadData()
        
    }
    
}
