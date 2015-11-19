//
//  ViewController.swift
//  chat
//
//  Created by Peiyu Liu on 11/18/15.
//  Copyright © 2015 Peiyu Liu. All rights reserved.
//

import UIKit
import Parse

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var messageField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    
    var messages: [PFObject]!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        tableView.dataSource = self
        tableView.delegate = self
        
        messages = []
        
        reloadMessage()
        
        NSTimer.scheduledTimerWithTimeInterval(2, target: self, selector: "reloadMessage", userInfo: nil, repeats: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count

        
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("MessageCell") as! MessageCell
        let message = messages[indexPath.row]
        cell.messageLabel.text = message["text"] as? String
        return cell
        
    }
    @IBAction func didPressSendButton(sender: AnyObject) {
        let message = PFObject(className:"Message")
        message["text"] = messageField.text
        
        message.saveInBackgroundWithBlock { (satus: Bool, error: NSError?) -> Void in
            print("save succeed")
        }
        
    }
    
    func reloadMessage(){
        let query = PFQuery(className: "Message")
        query.orderByDescending("createdAt")
        query.findObjectsInBackgroundWithBlock { (objects:[PFObject]?, error:NSError?) -> Void in
        self.messages = objects
        self.tableView.reloadData()
            
            
        }

    }
    
}

