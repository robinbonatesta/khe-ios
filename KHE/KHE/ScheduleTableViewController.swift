//
//  ScheduleTableViewController.swift
//  KHE
//
//  Created by Paul Dilyard on 9/2/15.
//  Copyright (c) 2015 HacKSU. All rights reserved.
//

import UIKit
import SwiftDate

class ScheduleTableViewController: UITableViewController {
    
    // Array of events
    var events: [Events.Event] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        loadEvents()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // Return the number of sections.
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    // Return the number of rows
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.events.count
    }

    // Build each cell
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("ScheduleTableViewCell", forIndexPath: indexPath) as! ScheduleTableViewCell
        let event = self.events[indexPath.row]
        let start = event.start.toDate(format: DateFormat.ISO8601)
        let end = event.end.toDate(format: DateFormat.ISO8601)
        if let start = start {
            if let end = end {
                let startStr = start.toString(format: DateFormat.Custom("h:mma"))
                let endStr = end.toString(format: DateFormat.Custom("h:mma"))
                let datestring = "\(startStr.lowercaseString) - \(endStr.lowercaseString)"
                cell.timeLabel.text = datestring
            }
        }
        cell.locationLabel.text = event.location
        cell.nameLabel.text = event.title
        cell.descriptionLabel.text = event.description
        return cell
    }
    
    // Fetch a list of events
    func loadEvents() {
        Events.get { (err, response) in
            if let err = err {
                return
            }
            
            self.events = response.events
            
            self.tableView.reloadData()
        }
    }
    
    // Refresh button clicked
    @IBAction func actionRefresh(sender: UIBarButtonItem) {
        loadEvents()
    }
    
}
