//
//  RankQuestionCreateController.swift
//  Pollr
//
//  Created by Spencer Rothschild on 5/26/15.
//  Copyright (c) 2015 Kabir. All rights reserved.
//

import UIKit

class RankQuestionCreateController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {

    @IBOutlet weak var myTableView: UITableView!
    @IBOutlet weak var questionTextField: UITextField!
    var questions = [String]()
    var newQuestion: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.questionTextField.delegate = self
        questions = ["hi", "hello", "goodbye"]
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return questions.count

    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! UITableViewCell
        
        cell.textLabel!.text = questions[indexPath.row]
        
        return cell
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        
        if(editingStyle == UITableViewCellEditingStyle.Delete){
            
            questions.removeAtIndex(indexPath.row)
            
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Automatic)
        }
    }
    
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        
        questions.append(questionTextField.text)
        
        textField.resignFirstResponder()
        
        myTableView.reloadData()
        
        self.questionTextField.text = ""
        
        return true
    }
    
    
    @IBAction func addQuestion(sender: AnyObject) {
        
        if( "" == questionTextField.text){
            return
        }
        
        println(questionTextField.text)
        
        questions.append(questionTextField.text)
        
        myTableView.reloadData()
        
        self.questionTextField.text = ""
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
