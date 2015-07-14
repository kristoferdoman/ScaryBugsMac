//
//  AppDelegate.swift
//  ScaryBugsMac
//
//  Created by Kristofer Doman on 2015-07-09.
//  Copyright (c) 2015 Kristofer Doman. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    @IBOutlet weak var window: NSWindow!
    
    var masterViewController: MasterViewController!

    func applicationDidFinishLaunching(aNotification: NSNotification) {
        masterViewController = MasterViewController(nibName: "MasterViewController", bundle: nil)
        
        if let data = NSUserDefaults.standardUserDefaults().objectForKey("bugs") as? NSData {
            masterViewController.bugs = NSKeyedUnarchiver.unarchiveObjectWithData(data) as! [ScaryBugDoc]
        } else {
            masterViewController.setupSampleBugs()
        }
        
        window.contentView.addSubview(masterViewController.view)
        masterViewController.view.frame = (window.contentView as! NSView).bounds
        
        masterViewController.view.translatesAutoresizingMaskIntoConstraints = false
        let verticalConstraints = NSLayoutConstraint.constraintsWithVisualFormat("V:|[subView]|",
            options: NSLayoutFormatOptions(0),
            metrics: nil,
            views: ["subView" : masterViewController.view])
        let horizontalConstraints = NSLayoutConstraint.constraintsWithVisualFormat("H:|[subView]|",
            options: NSLayoutFormatOptions(0),
            metrics: nil,
            views: ["subView" : masterViewController.view])
        
        NSLayoutConstraint.activateConstraints(verticalConstraints + horizontalConstraints)
    }

    func applicationWillTerminate(aNotification: NSNotification) {
        masterViewController.saveBugs()
    }
}

