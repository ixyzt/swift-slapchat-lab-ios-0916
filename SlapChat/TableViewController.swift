//
//  TableViewController.swift
//  SlapChat
//
//  Created by Ian Rahman on 7/16/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

import UIKit
import CoreData

class TableViewController: UITableViewController {
    
    var store = DataStore.sharedInstance
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("View Starting to Load")
        store.fetchData()
        store.messages.sort (by: { $0.0.createdAt?.compare($0.1.createdAt as! Date) == ComparisonResult.orderedDescending })
//        store.generateTestData()
        
        dump(store.messages)
        print("View Loaded")
        
//        try! store.context.fetch(Message.fetchRequest())
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        store.fetchData()
        self.tableView.reloadData()
    }
    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return store.messages.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "messageCell", for: indexPath)
        
        cell.textLabel?.text = store.messages[indexPath.row].content
        cell.detailTextLabel?.text = "Timestamp: \(store.messages[indexPath.row].createdAt!)"
        
        return cell
    }
    
    
    
}
