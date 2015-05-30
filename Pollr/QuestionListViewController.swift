//
//  QuestionListViewController.swift
//  Pollr
//
//  Created by Kabir Gogia on 5/26/15.
//  Copyright (c) 2015 Kabir. All rights reserved.
//

import UIKit

class QuestionListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    var questions:[Question]?
    var MCSegue = "MCVoteSegue"
    var RankSegue = "RankVoteSegue"

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = self.tableView.dequeueReusableCellWithIdentifier("cell") as! QuestionListTableViewCell
        
        cell.question = questions?[indexPath.row]
        cell.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
        //println("Type = \(questions?[indexPath.row].title!)")
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return questions?.count ?? 0
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == MCSegue {
            if let destination = segue.destinationViewController as? MCViewController {
                if let row = self.tableView.indexPathForSelectedRow()?.row {
                    self.tableView.deselectRowAtIndexPath(self.tableView.indexPathForSelectedRow()!, animated: true)
                    var q = questions?[row]
                    destination.question = q
                }
            }
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
