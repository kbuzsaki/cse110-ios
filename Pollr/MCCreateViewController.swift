//
//  MCCreateViewController.swift
//  Pollr
//
//  Created by Spencer Rothschild on 5/31/15.
//  Copyright (c) 2015 Kabir. All rights reserved.
//

import UIKit

class MCCreateViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {

    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var myTableView: UITableView!
    @IBOutlet weak var optionTextField: UITextField!
    
    
    var options = [String]()
    var newQuestion: String = ""
    
    //ChoiceQuestion.initFrom ({
    //  "type" : "choice / rank / schedule"
    //   "options": options,
    //    "allow_multiple": allow_multiple,
    //    "allow_custom": allow_custon,
    //})
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.optionTextField.delegate = self
        options = ["test", "test1", "test2"]
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func optionAddButton(sender: AnyObject) {
        
        if( "" == optionTextField.text){
            return
        }
        
        options.append(optionTextField.text)
        self.optionTextField.text = ""
        
        myTableView.reloadData()
    }
    
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        
        if (editingStyle == UITableViewCellEditingStyle.Delete){
            
            options.removeAtIndex(indexPath.row)
            
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Automatic)
        }
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! UITableViewCell
        
        cell.textLabel!.text = options[indexPath.row]
        
        return cell
        
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return options.count
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        options.append(optionTextField.text)
        
        textField.resignFirstResponder()
        
        myTableView.reloadData()
        
        self.optionTextField.text = ""
        
        return true
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
