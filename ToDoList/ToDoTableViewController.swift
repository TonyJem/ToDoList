//
//  ToDoTableViewController.swift
//  ToDoList
//
//  Created by Office-iMac on 2020-05-20.
//  Copyright © 2020 Tony Jem. All rights reserved.
//

import UIKit

class ToDoTableViewController: UITableViewController, ToDoCellDelegate {

    // Func below is necessary to ToDoTableViewController conform to protocol ToDoCellDelegate:
    func checkmarkTapped(sender: ToDoCell) {
        if let indexPath = tableView.indexPath(for: sender) {
            var todo = todos[indexPath.row]
            todo.isComplite = !todo.isComplite
            todos[indexPath.row] = todo
            tableView.reloadRows(at: [indexPath], with: .automatic)
        }
    }

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
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoCellIdentifier") as? ToDoCell else {
            fatalError("Could not dequeue a cell")
        }
        
        let todo = todos[indexPath.row]
        cell.titleLabel?.text = todo.title
        cell.isCompleteButton.isSelected = todo.isComplite
        cell.delegate = self
        
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

    //  unwind from child TableView back to Parent TableView when "Save" or "Cancel" buttons were tapped:
    @IBAction func unwindToToDoList(segue: UIStoryboardSegue){
        
        //    Verify that "saveUnwind" segue is being called:
        guard segue.identifier == "saveUnwind" else { return }
        
        //    Set dismissing view controller:
        let sourceViewController = segue.source as! ToDoDetailTableViewController
        
        //    Check to see if a model object exists in the segue's source:
        if let todo = sourceViewController.todo {
            
            // Check if in parent TableView was selected Row, if yes it means we are "editing":
            if let selectedIndexPath = tableView.indexPathForSelectedRow {
                todos[selectedIndexPath.row] = todo
                tableView.reloadRows(at: [selectedIndexPath], with: .none)
            } else {
                // if in parent TableView was not selected any Row ("selectedIndexPath" is nil)
                // It happens after user tapped "+" button, it means we are "creating New object",
                //  so need to add it to the array and to the new table cell:
                let newIndexPath = IndexPath(row: todos.count, section: 0)
                todos.append(todo)
                tableView.insertRows(at: [newIndexPath], with: .automatic)
            }
        }
    }

    //  Transfer data from Row to child TableView when Row in parent TableView is selected:
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        if segue.identifier == "EditToDo",
            let navController = segue.destination as? UINavigationController,
            let todoDetailTableViewController = navController.topViewController as? ToDoDetailTableViewController
        {
            let indexPath = tableView.indexPathForSelectedRow!
            let selectedToDo = todos[indexPath.row]
            todoDetailTableViewController.todo = selectedToDo
        }
    }
}
