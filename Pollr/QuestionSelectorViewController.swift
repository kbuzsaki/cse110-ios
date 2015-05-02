//
//  QuestionSelectorViewController.swift
//  Pollr
//
//  Created by Kabir Gogia on 5/1/15.
//  Copyright (c) 2015 Kabir. All rights reserved.
//

import UIKit

class QuestionSelectorViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var myTableView: UITableView!
    
    var items = ["Multiple Choice", "Rank Preference", "Schedule Integration"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.myTableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
        self.myTableView.dataSource = self
        self.myTableView.delegate = self

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell: UITableViewCell = self.myTableView.dequeueReusableCellWithIdentifier("cell") as! UITableViewCell
        
        cell.textLabel?.text = self.items[indexPath.row]
        cell.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
        
        return cell
    }

    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        var segue = tableView.cellForRowAtIndexPath(indexPath)!.textLabel?.text
        self.performSegueWithIdentifier(segue, sender: nil)
    }
    
    /*
    // MARK,: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
