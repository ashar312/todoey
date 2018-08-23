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
                let newitem = Item()
                newitem.title = textfield.text!
                self.itemarray.append(newitem)
                self.saveitem()
                
                
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
    var itemarray = [Item]()
    
    let datafile = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("items.plist")
    override func viewDidLoad() {
        super.viewDidLoad()

        let newitem = Item()
        
        
        loaddata()
         //      if let items = defaults.array(forKey: "ToDoeyList") as? [Item]
        //       {
        //           itemarray = items
       //        }
        
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemarray.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "todoitemcell", for: indexPath)
        
        cell.textLabel?.text = itemarray[indexPath.row].title
        
        
        cell.accessoryType = itemarray[indexPath.row].done == true ? .checkmark : .none
        
  //      if itemarray[indexPath.row].done == true{
  //          cell.accessoryType = .checkmark
  //      }
  //      else{
 //           cell.accessoryType = .none
 //       }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
      
        itemarray[indexPath.row].done = !itemarray[indexPath.row].done
        self.saveitem()
        
  //      if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark
  //      {
  //          tableView.cellForRow(at: indexPath)?.accessoryType = .none
 //       }
  //      else{
  //          tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
  //      }
        
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func saveitem()
    {
        let encoder = PropertyListEncoder()
        do {
            let data = try encoder.encode(itemarray)
            try data.write(to: datafile!)
        }
        catch {
            print("error : \(error)")
        }
        self.tableView.reloadData()
    }
    
    func loaddata()
    {
       if let data = try? Data(contentsOf : datafile! ){
                let decoder = PropertyListDecoder()
        do{
            itemarray =  try decoder.decode([Item].self, from: data)
        }
        catch{
            print("error : \(error)")
        }
        }
    }
    
    

}

