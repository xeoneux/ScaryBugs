//
//  AppDelegate.swift
//  ScaryBugs
//
//  Created by Aayush Kapoor on 30/10/15.
//  Copyright © 2015 Aayush Kapoor. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    var mainViewController: MainViewController!
    
    @IBOutlet weak var window: NSWindow!


    func applicationDidFinishLaunching(aNotification: NSNotification) {
        mainViewController = MainViewController(nibName: "MainViewController", bundle: nil)
        
        window.contentView!.addSubview(mainViewController.view)
        mainViewController.view.frame = window.contentView!.bounds
    }

    func applicationWillTerminate(aNotification: NSNotification) {
        // Insert code here to tear down your application
    }


}

