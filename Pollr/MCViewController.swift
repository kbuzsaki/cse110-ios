//
//  MCViewController.swift
//  Pollr
//
//  Created by Matthew Roknich on 5/24/15.
//  Copyright (c) 2015 Kabir. All rights reserved.
//

import UIKit

class MCViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var tableView = UITableView()
    var showsArray = Array<String>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        tableView = UITableView(frame: self.view.frame)
        
        tableView.separatorColor = UIColor.clearColor()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        self.view.addSubview(tableView)
        
        showsArray = ["Tap to enter an option"]
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int
    {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return showsArray.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let cellFrame = CGRectMake(0, 0, self.tableView.frame.width, 52.0)
        var retCell = UITableViewCell(frame: cellFrame)
        retCell.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
        
        var textLabel = UILabel(frame: CGRectMake(10.0, 0.0, UIScreen.mainScreen().bounds.width - 20.0, 52.0 - 4.0))
        textLabel.textColor = UIColor.blackColor()
        textLabel.text = showsArray[indexPath.row]
        retCell.addSubview(textLabel)
        
        return retCell
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat
    {
        return 52.0
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat
    {
        if section == 0
        {	return 64.0
        }
        
        return 32.0
    }
    
    func tableView(tableView: UITableView, editActionsForRowAtIndexPath indexPath: NSIndexPath) -> [AnyObject]? {
        let add = UITableViewRowAction(style: .Normal, title: "Add") { action, index in
            println("add button tapped")
        }
        add.backgroundColor = UIColor.darkGrayColor()
        
        let remove = UITableViewRowAction(style: .Normal, title: "Remove") { action, index in
            println("remove button tapped")
        }
        remove.backgroundColor = UIColor.blueColor()
        
        return [remove, add]
    }
    
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // the cells you would like the actions to appear needs to be editable
        return true
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        // you need to implement this method too or you can't swipe to display the actions
    }
    
    
    @IBAction func addOption(sender: AnyObject) {
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
