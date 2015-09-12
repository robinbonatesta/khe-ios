//
//  MessagesTableViewController.swift
//  KHE
//
//  Created by Paul Dilyard on 9/3/15.
//  Copyright (c) 2015 HacKSU. All rights reserved.
//

import UIKit
import SwiftDate
import Bumblebee

class MessagesTableViewController: UITableViewController {
    
    var messages: [Messages.Message] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        loadMessages()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // Return the number of sections.
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Return the number of rows in the section.
        return self.messages.count
    }

    // Build a cell
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let message = messages[indexPath.row]
        let cell = tableView.dequeueReusableCellWithIdentifier("MessagesTableViewCell", forIndexPath: indexPath) as! MessagesTableViewCell
        
        let bee = BumbleBee()
        bee.add("**?**", recursive: false) { (pattern, text, start) -> (String, [NSObject : AnyObject]?) in
            let replace = pattern[advance(pattern.startIndex, 2)...advance(pattern.endIndex, -3)]
            return (replace, [NSFontAttributeName: UIFont.boldSystemFontOfSize(17)])
        }
        bee.add("_?_", recursive: false) { (pattern, text, start) -> (String, [NSObject : AnyObject]?) in
            let replace = pattern[advance(pattern.startIndex, 1)...advance(pattern.endIndex, -2)]
            return (replace, [NSFontAttributeName: UIFont.italicSystemFontOfSize(17)])
        }
//        bee.add("[?](?)", recursive: false) { (pattern, text, start) -> (String, [NSObject : AnyObject]?) in
//            let end = pattern.rangeOfString("]")
//            let replace = pattern[advance(pattern.startIndex, 1)...advance(end!.endIndex, -2)]
//            let range = NSMakeRange(start, count(replace))
//            cell.messageLabel.addLinkToURL(NSURL(string: "http://google.com"), withRange: range)
//            return (replace, [NSFontAttributeName: UIFont.systemFontOfSize(17)])
//        }
        
        cell.messageLabel.attributedText = bee.process(message.text)
        
        let created = message.created.toDate(format: DateFormat.ISO8601)
        if let created = created {
            cell.dateLabel.text = created.toString(format: DateFormat.Custom("EEEE, h:mma"))
        }
        
        return cell
    }

    // Fetch a list of messages
    func loadMessages() {
        Messages.get { (err, response) in
            if let err = err {
                return
            }
            self.messages = response.messages
            self.tableView.reloadData()
        }
    }

}
