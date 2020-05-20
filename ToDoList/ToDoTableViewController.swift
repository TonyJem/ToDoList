//
//  ToDoTableViewController.swift
//  ToDoList
//
//  Created by Office-iMac on 2020-05-20.
//  Copyright © 2020 Tony Jem. All rights reserved.
//

import UIKit

class ToDoTableViewController: UITableViewController {
    
    //    Create an empty array of model objects:
    var todos = [ToDo]()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let savedToDos = ToDo.loadToDos() {
            todos = savedToDos
        } else {
            todos = ToDo.loadSampleToDos()
        }
        // Add "Edit" button in navigation bar for switching On/Off "Edit" mode:
         self.navigationItem.leftBarButtonItem = self.editButtonItem
    }
    
    // MARK: - Table view data source
    
    //    Number of sections:
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    //    Number of rows:
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todos.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoCellIdentifier", for: indexPath)
        
        let todo = todos[indexPath.row]
        cell.textLabel?.text = todo.title
        
        return cell
    }
    
    
     // Enable rows to be editable:
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true    // Return false if you do not want the specified item to be editable.
     }
    
    // Enable rows to be deleted when "Edit" mode is On:
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data array and from Table View:
            todos.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    /*
     // Override to support rearranging the table view.
     override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
     
     }
     */
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */
    
     // MARK: - Navigation
     
    @IBAction func unwindToToDoList(segue: UIStoryboardSegue){
        
    }
        /*
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
