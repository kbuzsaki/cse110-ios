//
//  MCViewController.swift
//  Pollr
//
//  Created by Kabir Gogia on 5/23/15.
//  Copyright (c) 2015 Kabir. All rights reserved.
//

import UIKit


class MCViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    var textCellIdentifier = "QuestionCell"
    var question:Question?
    @IBOutlet weak var questionTitleLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        questionTitleLabel.text = question?.title
        self.tableView.dataSource = self
        self.tableView.delegate = self
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func packageResponses(sender: UIBarButtonItem) {
        
        var dict = [NSObject: AnyObject]()

        for var i = 0; i < question!.options!.count; i++  {
            var index:NSObject = i
            var option:AnyObject = question!.options![i]
            if question?.type == "choice" {
                var cell = tableView.cellForRowAtIndexPath(NSIndexPath(forRow: i, inSection: 0)) as! MCOptionTableViewCell
                
                if cell.colorChanged {
                    dict[index] = cell.option!
                }
                
            } else {
                dict[index] = option
            }
        }
        var response = Response.initFrom(propertyList: dict)
        println(dict)
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(textCellIdentifier, forIndexPath: indexPath) as! MCOptionTableViewCell
        
        cell.option = question?.options?[indexPath.row]
        cell.showsReorderControl = question?.type == "rank"
        cell.setEditing(true, animated: true)
        
        println("Cell Option = \(cell.option)")
        return cell
    }

    func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    func tableView(tableView: UITableView, moveRowAtIndexPath sourceIndexPath: NSIndexPath, toIndexPath destinationIndexPath: NSIndexPath) {
        
        var temp = question?.options?[destinationIndexPath.row]
        question!.options![destinationIndexPath.row] = question!.options![sourceIndexPath.row]
        question!.options![sourceIndexPath.row] = temp!
    }
    
    func tableView(tableView: UITableView, targetIndexPathForMoveFromRowAtIndexPath sourceIndexPath: NSIndexPath, toProposedIndexPath proposedDestinationIndexPath: NSIndexPath) -> NSIndexPath {
        var fromRow = sourceIndexPath.row
        var toRow = proposedDestinationIndexPath.row
        
        println("From: \(fromRow)")
        println("To:   \(toRow)")
        
        return proposedDestinationIndexPath
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        question?.inflate()
        return question!.options!.count
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {

        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        if question?.type == "rank" {
            return
        }
        
        var cell = tableView.cellForRowAtIndexPath(indexPath) as! MCOptionTableViewCell
        cell.colorChanged = !cell.colorChanged
        
        
        for var index = 0; index < question!.options!.count; ++index {
            
            if index != indexPath.row {
                var tempIndexPath = NSIndexPath(forRow: index, inSection: 0)
                var tempCell = tableView.cellForRowAtIndexPath(tempIndexPath) as! MCOptionTableViewCell
                if tempCell.colorChanged {
                    tempCell.colorChanged = false
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
