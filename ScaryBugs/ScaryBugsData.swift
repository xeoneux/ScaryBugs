//
//  ScaryBugsData.swift
//  ScaryBugs
//
//  Created by Aayush Kapoor on 30/10/15.
//  Copyright © 2015 Aayush Kapoor. All rights reserved.
//

import Cocoa

class ScaryBugsData: NSObject {
    
    var title: String
    var rating: Double
    
    override init() {
        self.title = String()
        self.rating = 0.0
    }
    
    init(title: String, rating: Double) {
        self.title = title
        self.rating = rating
    }

}
