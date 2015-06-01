//
//  JoinPollTableViewController.swift
//  Pollr
//
//  Created by Ran Tao on 5/31/15.
//  Copyright (c) 2015 Kabir. All rights reserved.
//

import UIKit

class JoinPollTableViewController: UITableViewController {
    
    @IBOutlet weak var joinButton: UIBarButtonItem!
    @IBOutlet weak var enterCodeField: UITextField!
    
    var handleNewPollCallback: ((Poll) -> Void)?
    
    var alert = UIAlertController(title: "Invalid Code",
        message: "We couldn't find the poll. Did you enter the code correctly?",
        preferredStyle: .Alert)
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        enterCodeField.becomeFirstResponder()
        
        // Enable/disable join button when text is entered.
        enterCodeField.addTarget(self, action: "enterCodeFieldChanged", forControlEvents: UIControlEvents.EditingChanged)
        
        // Initialize the alert.
        var defaultAction = UIAlertAction(title: "OK", style: .Default) {action in} // No handler.
        alert.addAction(defaultAction)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }
    @IBAction func cancel() {
        dismissViewControllerAnimated(true, completion: nil)
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return 1
    }
    
    @IBAction func validateCode() {
        let code = enterCodeField.text
        var (error, poll) = Poll.createWithAccessCode(code, userId: HomeViewController.id!)
        if let error = error {
            if error.isPollrError(ErrorCode.JOIN_POLL_INVALID_CODE) {
                // The code entered was invalid.
                presentViewController(alert, animated: true, completion: nil)
            } else {
                println(error.localizedDescription)
            }
        } else {
            if let callback = handleNewPollCallback, let poll = poll {
                dismissViewControllerAnimated(true) {
                    callback(poll)
                }
            } else if handleNewPollCallback == nil {
                // The callback should be set, or else something is wrong.
                println("Error: No callback provided to handle newly created poll in JoinPoll controller.")
                dismissViewControllerAnimated(true, completion: nil)
            } else if poll == nil {
                println("Error: No poll created with access code but no error produced in JoinPoll controller.")
                dismissViewControllerAnimated(true, completion: nil)
            }
        }
    }
    
    func enterCodeFieldChanged() {
        if enterCodeField.text.isEmpty {
            if joinButton.enabled {
                joinButton.enabled = false
            }
        } else {
            if !joinButton.enabled {
                joinButton.enabled = true
            }
        }
    }

    /*
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath) as! UITableViewCell

        // Configure the cell...

        return cell
    }
    */

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
        if segue.identifier == questionSegueIdentifier {
            if let destination = segue.destinationViewController as? QuestionListViewController {
                var questions: [Question]
                if let poll = poll, let pollQuestions = poll.questions {
                    questions = pollQuestions
                } else {
                    // This shouldn't happen.
                    println("Error: Segue to QuestionListView from JoinPoll but poll is empty"
                        + "or the questions of the poll is empty.")
                    questions = []
                }
                destination.questions = questions
            }
        }
    }
    */

}
