//
//  Team.swift
//  SearchControlApp
//
//  Created by Fethi El Hassasna on 1/10/17.
//  Copyright © 2017 Fethi El Hassasna. All rights reserved.
//

import Foundation

class Team {
    
    var name : String
    var imageName : String
    var stadium : String
    var website : String
    
    init(name: String, imageName: String, stadium: String, website: String) {
        
        self.name = name
        self.imageName = imageName
        self.stadium = stadium
        self.website = website
    }
    
    class func getTeams() -> [Team] {
        
        var teams = [Team]()
        
        var teamsArray: [Dictionary<String, String>]?
        
        if let path = Bundle.main.path(forResource: "Teams", ofType: "plist") {
            teamsArray = NSArray(contentsOfFile: path) as? Array
        }
        
        if let array = teamsArray {
            
            for item in array {
                
                guard let name = item["name"], let imageName = item["imageName"], let stadium = item["stadium"], let website = item["website"] else {
                        
                    print("Error in the Teams.plist file !")
                    break
                }
                
                let team = Team(name: name,
                                imageName: imageName,
                                stadium: stadium,
                                website: website)
                
                teams.append(team)
            }
        }
        
        return teams
    }
}
