//
//  MultipleChoiceCreateController.swift
//  Pollr
//
//  Created by Spencer Rothschild on 5/25/15.
//  Copyright (c) 2015 Kabir. All rights reserved.
//

import UIKit

class MultipleChoiceCreateController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var questionText: UITextField!
    @IBOutlet weak var myTableView: UITableView!
    var questions = [String]()
    var newQuestion: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        questions = ["test", "test1", "test2"]
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func addButton(sender: AnyObject) {
        
        questions.append(questionText.text)
        
        myTableView.reloadData()
        
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        
        if (editingStyle == UITableViewCellEditingStyle.Delete){
        
            questions.removeAtIndex(indexPath.row)
            
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Automatic)
        }
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! UITableViewCell
        
        cell.textLabel!.text = questions[indexPath.row]
        
        return cell
        
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return questions.count
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
