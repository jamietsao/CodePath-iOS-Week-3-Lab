//
//  MessageViewController.swift
//  CodePathLab3Parse
//
//  Created by Steffan Chartrand on 2/18/15.
//  Copyright (c) 2015 CodePath. All rights reserved.
//

import UIKit

class MessageViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    var messages: [String] = []
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var sendButton: UIButton!
    
    @IBAction func onSend(sender: AnyObject) {
        let text = textField.text
        var message = PFObject(className:"Message")
        message["text"] = text
        message.saveInBackgroundWithBlock {
            (success: Bool, error: NSError!) -> Void in
            if (success) {
                NSLog("Message success: " + text)
                self.textField.text = ""
                // The object has been saved.
            } else {
                NSLog("Message save fail: \(error)")
                // There was a problem, check error.description
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.dataSource = self
        tableView.delegate = self
        
        NSTimer.scheduledTimerWithTimeInterval(0.5, target: self, selector: "onTimer", userInfo: nil, repeats: true)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let message = messages[indexPath.row]
        let cell = tableView.dequeueReusableCellWithIdentifier("messageCell", forIndexPath: indexPath) as MessageCell
        cell.message.text = message
        return cell
    }

    func onTimer() {
        var query = PFQuery(className:"Message")
        query.orderByDescending("createdAt")
        query.findObjectsInBackgroundWithBlock {
            (objects: [AnyObject]!, error: NSError!) -> Void in
            if error == nil {
                // The find succeeded.
                NSLog("Successfully retrieved \(objects.count) scores.")
                // Do something with the found objects
                self.messages = []
                for obj in objects {
                    var message = obj as PFObject
                    self.messages.append(message["text"] as String)
                }
                self.tableView.reloadData()
            } else {
                // Log details of the failure
                NSLog("Error: %@ %@", error, error.userInfo!)
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
