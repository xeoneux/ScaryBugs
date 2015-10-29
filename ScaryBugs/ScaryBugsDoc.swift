//
//  ScaryBugsDoc.swift
//  ScaryBugs
//
//  Created by Aayush Kapoor on 30/10/15.
//  Copyright © 2015 Aayush Kapoor. All rights reserved.
//

import Cocoa

class ScaryBugsDoc: NSObject {

    var data: ScaryBugsData
    var thumbImage: NSImage?
    var fullImage: NSImage?
    
    override init() {
        self.data = ScaryBugsData()
    }
    
    init(title: String, rating: Double, thumbImage: NSImage?, fullImage: NSImage?) {
        self.data = ScaryBugsData(title: title, rating: rating)
        self.thumbImage = thumbImage
        self.fullImage = fullImage
    }
    
}
