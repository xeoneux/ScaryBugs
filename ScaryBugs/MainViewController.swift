//
//  MainViewController.swift
//  ScaryBugs
//
//  Created by Aayush Kapoor on 30/10/15.
//  Copyright © 2015 Aayush Kapoor. All rights reserved.
//

import Cocoa
import Quartz

class MainViewController: NSViewController {
    
    @IBOutlet weak var bugsTableView: NSTableView!
    @IBOutlet weak var bugTitleView: NSTextField!
    @IBOutlet weak var bugImageView: NSImageView!
    @IBOutlet weak var bugRating: EDStarRating!
    
    @IBOutlet weak var deleteButton: NSButton!
    @IBOutlet weak var changePictureButton: NSButton!
    
    var bugs: [ScaryBugsDoc]!

    override func viewDidLoad() {
        super.viewDidLoad()
        deleteButton.enabled = false
        changePictureButton.enabled = false
    }
    
    func setupSampleBugs() {
        let bug1 = ScaryBugsDoc(title: "Potato Bug", rating: 4.0,
            thumbImage:NSImage(named: "potatoBugThumb"), fullImage: NSImage(named: "potatoBug"))
        let bug2 = ScaryBugsDoc(title: "House Centipede", rating: 3.0,
            thumbImage:NSImage(named: "centipedeThumb"), fullImage: NSImage(named: "centipede"))
        let bug3 = ScaryBugsDoc(title: "Wolf Spider", rating: 5.0,
            thumbImage:NSImage(named: "wolfSpiderThumb"), fullImage: NSImage(named: "wolfSpider"))
        let bug4 = ScaryBugsDoc(title: "Lady Bug", rating: 1.0,
            thumbImage:NSImage(named: "ladybugThumb"), fullImage: NSImage(named: "ladybug"))
        
        bugs = [bug1, bug2, bug3, bug4]
    }
    
    func selectedBugDoc() -> ScaryBugsDoc? {
        let selectedRow = self.bugsTableView.selectedRow
        if selectedRow >= 0 && selectedRow < self.bugs.count {
            return self.bugs[selectedRow]
        }
        return nil
    }
    
    func updateDetailInfo(doc: ScaryBugsDoc?) {
        var title = ""
        var image: NSImage?
        var rating = 0.0
        
        if let scaryBugDoc = doc {
            title = scaryBugDoc.data.title
            image = scaryBugDoc.fullImage
            rating = scaryBugDoc.data.rating
        }
        
        self.bugTitleView.stringValue = title
        self.bugImageView.image = image
        self.bugRating.rating = Float(rating)
    }
    
    func reloadSelectedRow() {
        let rowSet = NSIndexSet(index: self.bugsTableView.selectedRow)
        let columnSet = NSIndexSet(index: 0)
        self.bugsTableView.reloadDataForRowIndexes(rowSet, columnIndexes: columnSet)
    }
    
    override func loadView() {
        super.loadView()
        
        self.bugRating.starHighlightedImage = NSImage(named: "shockedface2_full.png")
        self.bugRating.starImage = NSImage(named: "shockedface2_empty.png")
        
        self.bugRating.delegate = self
        
        self.bugRating.maxRating = 5
        self.bugRating.horizontalMargin = 12
        self.bugRating.editable = true
        self.bugRating.displayMode = UInt(EDStarRatingDisplayFull)
        
        self.bugRating.rating = Float(0.0)
    }
    
}

// MARK: - NSTableViewDataSource
extension MainViewController: NSTableViewDataSource {
    func numberOfRowsInTableView(aTableView: NSTableView) -> Int {
        return self.bugs.count
    }
    
    func tableView(tableView: NSTableView, viewForTableColumn tableColumn: NSTableColumn?, row: Int) -> NSView? {

        let cellView: NSTableCellView = tableView.makeViewWithIdentifier(tableColumn!.identifier, owner: self) as! NSTableCellView
        

        if tableColumn!.identifier == "Bugs" {

            let bugDoc = self.bugs[row]
            cellView.imageView!.image = bugDoc.thumbImage
            cellView.textField!.stringValue = bugDoc.data.title
            return cellView
            
        }
        
        return cellView
    }
}

// MARK: - NSTableViewDelegate
extension MainViewController: NSTableViewDelegate {
    func tableViewSelectionDidChange(notification: NSNotification) {
        let selectedDoc = selectedBugDoc()
        updateDetailInfo(selectedDoc)
        
        let buttonsEnabled = (selectedBugDoc() != nil)
        
        deleteButton.enabled = buttonsEnabled
        changePictureButton.enabled = buttonsEnabled
    }
}

// MARK: - EDStarRatingProtocol
extension MainViewController: EDStarRatingProtocol {
    
    func starsSelectionChanged(control: EDStarRating!, rating: Float) {
        if let selectedDoc = selectedBugDoc() {
            selectedDoc.data.rating = Double(self.bugRating.rating)
        }
    }
    
}

extension MainViewController {
    
    @IBAction func bugTitleDidEndEdit(sender: AnyObject) {
        
        if let selectedDoc = selectedBugDoc() {
            selectedDoc.data.title = self.bugTitleView.stringValue
            reloadSelectedRow()
        }
        
    }
    
    @IBAction func changePicture(sender: AnyObject) {
        
        if selectedBugDoc() != nil {
            IKPictureTaker().beginPictureTakerSheetForWindow(self.view.window, withDelegate: self, didEndSelector: "pictureTakerDidEnd", contextInfo: nil)
        }
        
    }
    
    @IBAction func deleteBug(sender: AnyObject) {
        
        if selectedBugDoc() != nil {
            self.bugs.removeAtIndex(self.bugsTableView.selectedRow)
            self.bugsTableView.removeRowsAtIndexes(NSIndexSet(index: self.bugsTableView.selectedRow), withAnimation: NSTableViewAnimationOptions.SlideRight)
            updateDetailInfo(nil)
        }
        
    }
    
    @IBAction func resetBug(sender: AnyObject) {
        
        setupSampleBugs()
        updateDetailInfo(nil)
        bugsTableView.reloadData()
        
    }
    
    @IBAction func addBug(sender: AnyObject) {
        
        let newDoc = ScaryBugsDoc(title: "New Bug", rating: 0.0, thumbImage: nil, fullImage: nil)
        self.bugs.append(newDoc)
        
        let newRowIndex = self.bugs.count - 1
        self.bugsTableView.insertRowsAtIndexes(NSIndexSet(index: newRowIndex), withAnimation: NSTableViewAnimationOptions.EffectFade)
        self.bugsTableView.selectRowIndexes(NSIndexSet(index: newRowIndex), byExtendingSelection: false)
        self.bugsTableView.scrollRowToVisible(newRowIndex)
        
    }
}