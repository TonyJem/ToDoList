// For SearchBar with some ajustments was used code from this tutorial: https://www.raywenderlich.com/4363809-uisearchcontroller-tutorial-getting-started#toc-anchor-003

import UIKit

// Essential method to conform to protocol UISearchResultsUpdating:
extension ToDoTableViewController: UISearchResultsUpdating {
    func updateSearchResults (for searchController: UISearchController) {
        let searchBar = searchController.searchBar
        filterContentForSearchText(searchBar.text!)
    }
}

class ToDoTableViewController: UITableViewController, ToDoCellDelegate {

    // Func below is necessary to ToDoTableViewController conform to protocol ToDoCellDelegate:
    func checkmarkTapped(sender: ToDoCell) {
        if let indexPath = tableView.indexPath(for: sender) {
            var todo = todos[indexPath.row]
            todo.isComplite = !todo.isComplite
            todos[indexPath.row] = todo
            tableView.reloadRows(at: [indexPath], with: .automatic)
            ToDo.saveToDos(todos)
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
        
        // Set Up SearchController's Parameters:
            //  ToDoTableViewController will be informed about any changes within the Search Bar:
            searchController.searchResultsUpdater = self
            //  Do not need to obscure the parent VieWController:
            searchController.obscuresBackgroundDuringPresentation = false
            //  Text to show in placeholder:
            searchController.searchBar.placeholder = "Search ToDos..."
            //  Put searchBar to navigation bar:
            self.navigationItem.searchController = self.searchController
            //  Ensure that searchBar doesn't remain on the screen if the user navigates to another view controller while the UISearchController is active:
            definesPresentationContext = true
    }

    // MARK: - Search Bar:
    let searchController = UISearchController(searchResultsController: nil) //By puting nil, we tell to SearchBar that results will be desplayed in same ViewController
    
    var filteredToDos: [ToDo] = [] // hold candidates that the user searches for.
    var isSearchBarEmpty: Bool { // Computed property to return True if the text typed in the search bar is empty.
        return searchController.searchBar.text?.isEmpty ?? true
    }
    
    var isFiltering: Bool { // Computed property to determnine if user is currently filtering results or not.
      return searchController.isActive && !isSearchBarEmpty
    }
    
//    Filter ToDo's titles based on searchText:
    func filterContentForSearchText(_ searchText: String) {
      filteredToDos = todos.filter { (todo: ToDo) -> Bool in
        return todo.title.lowercased().contains(searchText.lowercased())
      }
      
      tableView.reloadData()
    }

    // MARK: - Table view data source

    //    Number of sections:
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    //    Number of rows:
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFiltering { // Check whether the user is searching or not
            return filteredToDos.count
        } else {
            return todos.count
        }
    }

    //    Cell for Row at:
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoCellIdentifier") as? ToDoCell else {
            fatalError("Could not dequeue a cell")
        }
        
        let todo: ToDo
        if isFiltering{ // Check whether the user is searching or not
            todo = filteredToDos[indexPath.row]
        } else {
            todo = todos[indexPath.row]
        }
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
            ToDo.saveToDos(todos)
        }
    }

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
        ToDo.saveToDos(todos)
    }

    //  Transfer data from Row to child TableView when Row in parent TableView is selected:
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        if segue.identifier == "EditToDo",
            let navController = segue.destination as? UINavigationController,
            let todoDetailTableViewController = navController.topViewController as? ToDoDetailTableViewController
        {
            let indexPath = tableView.indexPathForSelectedRow!
            
            let selectedToDo: ToDo
            if isFiltering{ // Check whether the user is searching or not
                selectedToDo = filteredToDos[indexPath.row]
            } else {
                selectedToDo = todos[indexPath.row]
            }
            
            todoDetailTableViewController.todo = selectedToDo
        }
    }
}
