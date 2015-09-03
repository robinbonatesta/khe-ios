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
    
    var events: [Events.Event] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        // Fetch a list of messages
        Events.get { (err, response) in
            if let err = err {
                return
            }
            
            self.events = response.events
            
            self.tableView.reloadData()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // Return the number of sections.
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.events.count
    }

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

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

}
