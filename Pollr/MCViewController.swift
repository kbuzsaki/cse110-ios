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
    var questions:[Question]?
    @IBOutlet weak var questionTitleLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        questions?[0].inflate()
        println(questions?[0].title)
        questionTitleLabel.text = questions?[0].title
        self.tableView.dataSource = self
        self.tableView.delegate = self
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(textCellIdentifier, forIndexPath: indexPath) as! MCOptionTableViewCell
        cell.option = questions![0].options[indexPath.row]
        println("Cell Option = \(cell.option)")
        return cell
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return questions![0].options.count
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        var cell = tableView.cellForRowAtIndexPath(indexPath) as! MCOptionTableViewCell
        cell.colorChanged = !cell.colorChanged
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        
        for var index = 0; index < questions![0].options.count; ++index {
            
            if index != indexPath.row {
                println("here")
                var tempIndexPath = NSIndexPath(forRow: index, inSection: 0)
                var tempCell = tableView.cellForRowAtIndexPath(tempIndexPath)
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
