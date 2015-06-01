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
    let questionSegueIdentifier = "ShowQuestions"
    let joinPollSegueIdentifier = "JoinPoll"
    let questionFromPollSegueIdentifier = "ShowQuestionsFromPoll"
    static var id:Int? = 1
    var sentProcess = false
    let user = User.initFrom(1)
    
    // Poll created by Join Poll button.
    var poll: Poll?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
        dispatch_async(dispatch_get_global_queue(Int(QOS_CLASS_USER_INITIATED.value), 0)) {
            self.user.inflate()
            
            dispatch_async(dispatch_get_main_queue()) {
                self.tableView.reloadData()
            }
        }
        
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return user.groups?.count ?? 0 //user's groups are nil if inflating is not finished
    }

    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(textCellIdentifier, forIndexPath: indexPath) as! GroupTableViewCell
        
        cell.group = user.groups?[indexPath.row]
        cell.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
        
        return cell
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
//        if segue.identifier == pollViewSegueIdentifier {
//            if let destination = segue.destinationViewController as? ShowPollViewController {
//                if let row = tableView.indexPathForSelectedRow()?.row {
//                    var polls = user.groups?[row].polls
//                    destination.polls = polls
//                }
//            }
//        }
        
        if segue.identifier == questionSegueIdentifier {
            if let destination = segue.destinationViewController as? QuestionListViewController {
                if let row = tableView.indexPathForSelectedRow()?.row {
                    var questions = allQuestions(tableView.indexPathForSelectedRow()!)
                    destination.questions = questions
                }
            }
        }
        
        // Handle join poll segue
        if segue.identifier == joinPollSegueIdentifier {
            if let navController = segue.destinationViewController as? UINavigationController {
                if let destination = navController.topViewController as? JoinPollTableViewController {
                        destination.handleNewPollCallback = handleNewlyJoinedPoll
                }
            }
        }
        
        // Handle segue to newly joined poll.
        if segue.identifier == questionFromPollSegueIdentifier,
        let destination = segue.destinationViewController as? QuestionListViewController {
            var questions: [Question]
            if let poll = poll, let pollQuestions = poll.questions {
                questions = pollQuestions
            } else {
                // This shouldn't happen.
                println("Error: Segue to QuestionListView from HomeView using newly joined poll "
                    + "but poll is empty or the questions of the poll is empty.")
                questions = []
            }
            destination.questions = questions
        }
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    func allQuestions(indexPath:NSIndexPath) -> [Question]{
        var q = [Question]()
        self.user.inflate()
        
        
        //inflate the selected group
        //load up the selected groups polls
        //load all the questions from the selected groups polls
        
        user.groups![indexPath.row].inflate()
        var polls = user.groups![indexPath.row].polls
        for var i = 0; i < polls!.count; i++ {
            polls![i].inflate()
            for var j = 0; j < polls![i].questions!.count; j++ {
                q.append(polls![i].questions![j])
                println(q.last!.title!)
            }
        }
        
        return q
    }
    
    func handleNewlyJoinedPoll(poll: Poll) {
        self.poll = poll
        performSegueWithIdentifier(questionFromPollSegueIdentifier, sender: nil)
    }
}
