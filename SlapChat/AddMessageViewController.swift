//
//  AddMessageViewController.swift
//  SlapChat
//
//  Created by Bejan Fozdar on 11/8/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

import UIKit

class AddMessageViewController: UIViewController {
    
    var store = DataStore.sharedInstance
    
    @IBOutlet weak var newMessageField: UITextField!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func newMessageButton(_ sender: Any) {
        let date = NSDate()
        
        store.createNewMessage(message: newMessageField.text!, createdAt: date)
        store.saveContext()
    
        self.dismiss(animated: true)
        
        
    }
    

}
