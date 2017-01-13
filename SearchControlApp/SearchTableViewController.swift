//
//  SearchTableViewController.swift
//  SearchControlApp
//
//  Created by Fethi El Hassasna on 7/25/15.
//  Copyright (c) 2015 Fethi El Hassasna. All rights reserved.
//

import UIKit

class SearchTableViewController: UITableViewController, UISearchResultsUpdating {
    
    
    
    var teams : [Team]!
    var filtredTeams = [Team]()
    var resultSeachController : UISearchController!

    override func viewDidLoad() {
        super.viewDidLoad()

        // initiate the SeachController with an empty UISearchController
        self.resultSeachController = UISearchController(searchResultsController: nil)
        
        self.resultSeachController.searchResultsUpdater = self
        self.resultSeachController.dimsBackgroundDuringPresentation = false
        self.resultSeachController.searchBar.sizeToFit()
        
        self.title = "PL Teams"
        
        self.teams = Team.getTeams()
        
        self.tableView.tableHeaderView = self.resultSeachController.searchBar

        
        self.tableView.reloadData()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        // Test if resultSeachController is active to return filtred array count
        
        if self.resultSeachController.isActive {
            return self.filtredTeams.count
        } else {
            return self.teams.count
        }
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) 
        
        var team : Team!
        
        // Test if resultSeachController is active to display the filtred array
        
        if self.resultSeachController.isActive {
            team = self.filtredTeams[indexPath.row]
        } else {
            team = self.teams[indexPath.row]
        }
        
        cell.textLabel?.text = team.name
        cell.imageView?.image = UIImage(named: team.imageName)
        cell.detailTextLabel?.text = "🏟 " + team.stadium
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 80.0
    }
    
    // MARK: - UISearchResultsUpdating
    
    func updateSearchResults(for searchController: UISearchController) {
        
        // Remove all filtredTeams items
        self.filtredTeams.removeAll(keepingCapacity: false)
        
        // Create a Predicate
        let searchPredicate = NSPredicate(format: "SELF.name CONTAINS[c] %@", searchController.searchBar.text!)
        
        // Create NSArray (this array represent SELF in the Predicate above)
        let array = (self.teams as NSArray).filtered(using: searchPredicate)
        
        // New filtredTeams from the array result
        self.filtredTeams = array as! [Team]
        
        // Reload TableView data
        self.tableView.reloadData()
        
    }
    
}
