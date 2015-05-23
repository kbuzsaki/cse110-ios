//
//  HomeViewController.swift
//  Pollr
//
//  Created by Kabir Gogia on 5/18/15.
//  Copyright (c) 2015 Kabir. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet var tableView: UITableView!
    let textCellIdentifier = "TextCell"
    let pollViewSegueIdentifier = "ShowPolls"
    var id:Int? = 1
    let user = User.initFrom(1)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        user.inflate()
        return user.groups!.count
    }

    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(textCellIdentifier, forIndexPath: indexPath) as! GroupTableViewCell
        
        user.inflate()
        cell.group = user.groups?[indexPath.row]
        println(user.groups?[indexPath.row].inflate())
        cell.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
        
        return cell
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == pollViewSegueIdentifier {
            if let destination = segue.destinationViewController as? ShowPollViewController {
                if let row = tableView.indexPathForSelectedRow()?.row {
                }
            }
        }
    }
    
}
