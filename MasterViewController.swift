//
//  MasterViewController.swift
//  ScaryBugsMac
//
//  Created by Kristofer Doman on 2015-07-09.
//  Copyright (c) 2015 Kristofer Doman. All rights reserved.
//

import Cocoa

class MasterViewController: NSViewController {

    @IBOutlet weak var bugsTableView: NSTableView!
    @IBOutlet weak var bugTitleTextField: NSTextField!
    @IBOutlet weak var bugImageView: NSImageView!
    @IBOutlet weak var bugRating: EDStarRating!
    
    var bugs = [ScaryBugDoc]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
    }
    
    override func loadView() {
        super.loadView()
        
        self.bugRating.starImage = NSImage(named: "star.png")
        self.bugRating.starHighlightedImage = NSImage(named: "shockedface2_full.png")
        self.bugRating.starImage = NSImage(named: "shockedface2_empty.png")
        
        self.bugRating.delegate = self
        
        self.bugRating.maxRating = 5
        self.bugRating.horizontalMargin = 12
        self.bugRating.editable = true
        self.bugRating.displayMode = UInt(EDStarRatingDisplayFull)
        
        self.bugRating.rating = Float(0.0)
    }
    
    func setupSampleBugs() {
        let bug1 = ScaryBugDoc(title: "Potato Bug", rating: 4.0, thumbImage:NSImage(named: "potatoBugThumb"), fullImage: NSImage(named: "potatoBug"))
        let bug2 = ScaryBugDoc(title: "House Centipede", rating: 3.0, thumbImage:NSImage(named: "centipedeThumb"), fullImage: NSImage(named: "centipede"))
        let bug3 = ScaryBugDoc(title: "Wolf Spider", rating: 5.0, thumbImage:NSImage(named: "wolfSpiderThumb"), fullImage: NSImage(named: "wolfSpider"))
        let bug4 = ScaryBugDoc(title: "Lady Bug", rating: 1.0, thumbImage:NSImage(named: "ladybugThumb"), fullImage: NSImage(named: "ladybug"))
        
        bugs = [bug1, bug2, bug3, bug4]
    }
    
    func selectedBugDoc() -> ScaryBugDoc? {
        let selectedRow = self.bugsTableView.selectedRow
        
        if selectedRow >= 0 && selectedRow < self.bugs.count {
            return self.bugs[selectedRow]
        }
        
        return nil
    }
    
    func updateDetailInfo(doc: ScaryBugDoc?) {
        var title = ""
        var image: NSImage?
        var rating = 0.0
        
        if let scaryBugDoc = doc {
            title = scaryBugDoc.data.title
            image = scaryBugDoc.fullImage
            rating = scaryBugDoc.data.rating
        }
        
        self.bugTitleTextField.stringValue = title
        self.bugImageView.image = image
        self.bugRating.rating = Float(rating)
    }
}

// MARK: - NSTableViewDataSource

extension MasterViewController: NSTableViewDataSource {
    func numberOfRowsInTableView(aTableView: NSTableView) -> Int {
        return self.bugs.count
    }
    
    func tableView(tableView: NSTableView, viewForTableColumn tableColumn: NSTableColumn?, row: Int) -> NSView? {
        var cellView: NSTableCellView = tableView.makeViewWithIdentifier(tableColumn!.identifier, owner: self) as! NSTableCellView

        if tableColumn!.identifier == "BugColumn" {
            let bugDoc = self.bugs[row]
            cellView.imageView!.image = bugDoc.thumbImage
            cellView.textField!.stringValue = bugDoc.data.title
            return cellView
        }
        
        return cellView
    }
}

// MARK: - NSTableViewDelegate

extension MasterViewController: NSTableViewDelegate {
    func tableViewSelectionDidChange(notification: NSNotification) {
        let selectedDoc = selectedBugDoc()
        updateDetailInfo(selectedDoc)
    }
}

// MARK: - EDStarRatingProtocol

extension MasterViewController: EDStarRatingProtocol {
    
}

// MARK: - IBActions

extension MasterViewController {

    @IBAction func addBug(sender: AnyObject) {
        let newDoc = ScaryBugDoc(title: "New Bug", rating: 0.0, thumbImage: nil, fullImage: nil)
        
        self.bugs.append(newDoc)
        let newRowIndex = self.bugs.count - 1
        
        self.bugsTableView.insertRowsAtIndexes(NSIndexSet(index: newRowIndex), withAnimation: NSTableViewAnimationOptions.EffectGap)
        self.bugsTableView.selectRowIndexes(NSIndexSet(index: newRowIndex), byExtendingSelection: false)
        self.bugsTableView.scrollRowToVisible(newRowIndex)
    }
    
    @IBAction func removeBug(sender: AnyObject) {
    }
    
}


