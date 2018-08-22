//
//  ViewController.swift
//  todoey
//
//  Created by Ashar Ashfaq on 5/29/1397 AP.
//  Copyright © 1397 Ashar Ashfaq. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {

    @IBAction func barbutton(_ sender: UIBarButtonItem) {
        var textfield = UITextField()
        
        let alert = UIAlertController(title: "Add new Item", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add Item", style: .default) {(action) in
            if textfield.text != ""
            {
                self.itemarray.append(textfield.text!)
                self.defaults.set(self.itemarray, forKey: "ToDoeyList")
                
                self.tableView.reloadData()
            }
            
            
        }
        alert.addTextField { (alerttextfield) in
            alerttextfield.placeholder = "create new item"
            print(alerttextfield.text!)
            textfield = alerttextfield
        }
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
        
    }
    var itemarray = ["apple","banana","grape"]
    
    let defaults = UserDefaults.standard
    override func viewDidLoad() {
        super.viewDidLoad()
        if let items = defaults.array(forKey: "ToDoeyList") as? [String]
        {
            itemarray = items
        }
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemarray.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "todoitemcell", for: indexPath)
        
        cell.textLabel?.text = itemarray[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
      //  print(itemarray[indexPath.row])
        print(itemarray[indexPath.row])
        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark
        {
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
        }
        else{
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }
        
        
        tableView.deselectRow(at: indexPath, animated: true)
    }

}

