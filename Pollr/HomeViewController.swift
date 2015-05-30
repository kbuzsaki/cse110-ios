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
    var id:Int? = 1
    let user = User.initFrom(1)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let error = user.refresh() {
            println(error.localizedDescription)
            return 0
        }
        return user.groups!.count
    }

    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(textCellIdentifier, forIndexPath: indexPath) as! GroupTableViewCell
        
        user.inflate()
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
}
