//
//  KNNYTFeedViewController.swift
//  ITDemo
//
//  Created by Eugene Gubin on 6/26/15.
//  Copyright (c) 2015 Evgeniy Gubin. All rights reserved.
//

import UIKit

class KNNYTFeedViewController: UITableViewController {
    
    var feedEntries: [KNFeedEntry] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        if !KNNetworkUtils.isConnectedToNetwork() {
            UIAlertView(title: nil, message: "network.mustConnect".localized, delegate: nil, cancelButtonTitle: "common.ok".localized).show()
            return
        }
        
        asyncLoadRSSFeed()
    }
    
    func asyncLoadRSSFeed() {
        KNNYTParser.asyncParseFromURL(KNDefinitions.kNYTFeed) { result in
            self.feedEntries = result ?? []
            self.tableView.reloadData()
            
            if result == nil {
                UIAlertView(title: nil, message: "feed.error".localized, delegate: nil, cancelButtonTitle: "common.ok".localized).show()
            }
        }
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return feedEntries.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(KNDefinitions.kNYTFeedCell, forIndexPath: indexPath) as! UITableViewCell
        cell.textLabel!.text = feedEntries[indexPath.row].title
        return cell
    }
    
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            feedEntries.removeAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Left)
        }
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        super.prepareForSegue(segue, sender: sender)
        
        if (KNDefinitions.kSequeFeedEntry == segue.identifier) {
            let indexPath = tableView.indexPathForCell(sender as! UITableViewCell)!
            let entryVC = segue.destinationViewController as! KNEntryViewController
            entryVC.link = feedEntries[indexPath.row].link
        }
    }
}
