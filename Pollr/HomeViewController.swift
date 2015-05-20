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
    var id:Int? = 1
    let group = Group.initFrom(1)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }

    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(textCellIdentifier, forIndexPath: indexPath) as! GroupTableViewCell
        
        group.inflate()
        cell.group = group
        
        return cell
    }
    
}
