import UIKit
import MessageUI

class ToDoDetailTableViewController: UITableViewController, MFMailComposeViewControllerDelegate {

    var todo: ToDo?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let todo = todo { // When "Edit mode", then todo is coming from parent TableView with it's data:
//          load this data to child TableView items:
            navigationItem.title = "To-Do"
            titleTextField.text = todo.title
            isCompleteButton.isSelected = todo.isComplite
            dueDatePickerView.date = todo.dueDate
            notesTextView.text = todo.notes
        } else { // When "+ mode", then todo is nil and in child TableView all items will be setted to take new object's data from user:
            dueDatePickerView.date = Date().addingTimeInterval(20*60*60)
        }
        
        updateDueDateLabel(date: dueDatePickerView.date)
        updateSaveButtonState()
    }

    //    MARK: - Outlets:
    @IBOutlet var titleTextField: UITextField!
    @IBOutlet var isCompleteButton: UIButton!
    @IBOutlet var dueDateLabel: UILabel!
    @IBOutlet var dueDatePickerView: UIDatePicker!
    @IBOutlet var notesTextView: UITextView!

    //    MARK: - Save button:
    @IBOutlet var saveButton: UIBarButtonItem!
    
    @IBAction func textEditingChanged(_ sender: UITextField) {
        updateSaveButtonState()
    }

    //    Enable "Save" button if TextField is not Empty:
    func updateSaveButtonState(){
        let text = titleTextField.text ?? ""
        saveButton.isEnabled = !text.isEmpty
    }

    //    Read the values from the appropriate controls:
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        guard segue.identifier == "saveUnwind" else { return }
        
        let title = titleTextField.text!
        let isComplete = isCompleteButton.isSelected
        let dueDate = dueDatePickerView.date
        let notes = notesTextView.text
        
        //    Create model object and pass the readed values into it:
        todo = ToDo(title: title, isComplite: isComplete, dueDate: dueDate, notes: notes)
    }

    // MARK: - Send Email Button:
    @IBAction func sendEmailButtonTapped(_ sender: UIBarButtonItem) {
        // Check if user's device is can sed Emails:
        guard MFMailComposeViewController.canSendMail() else { return }
        
        let mailComposer = MFMailComposeViewController()
        mailComposer.mailComposeDelegate = self
        if let todo = todo {
            mailComposer.setSubject(todo.title)
            let notesFromToDo = todo.notes ?? ""
            let messageBody: String = """
                Hello, here is a new ToDo sent from \"ToDo\" App.
            Title: \(todo.title)
            Status: \(todo.status)
            Due Date: \(ToDo.dueDateFormatter.string(from: todo.dueDate))
            Extra notes:  \(notesFromToDo)
            """
            mailComposer.setMessageBody(messageBody, isHTML: false)
        }
        present(mailComposer, animated: true, completion: nil)
    }

    //  Dismiss Email sending view after e-mail is sent:
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        dismiss(animated: true, completion: nil)
    }

    //    MARK: - Dismiss Keyboard on Return:
    @IBAction func returnPressed(_ sender: UITextField) {
        titleTextField.resignFirstResponder()
    }

    //    MARK: - Change "isCompleteButton" Button image:
    @IBAction func isCompleteButtonTapped(_ sender: UIButton) {
        isCompleteButton.isSelected = !isCompleteButton.isSelected
    }

    //    MARK: - Update Date Label:
    @IBAction func datePickerChanged(_ sender: UIDatePicker) {
        updateDueDateLabel(date: dueDatePickerView.date)
    }

    func updateDueDateLabel(date: Date){
        dueDateLabel.text = ToDo.dueDateFormatter.string(from: date)
    }

    //    MARK: - Set all Cell Row Heights:
    var isPickerHidden: Bool = true

    let dateLabelIndexPath = IndexPath(row: 0, section: 1)
    let datePickerIndexPath = IndexPath(row: 1, section: 1)
    let notesTextViewIndexPath = IndexPath(row: 0, section: 2)

    let normalCellHeight: CGFloat = 44
    let largeCellHeight: CGFloat = 200

//    Set Row Heights:
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath {
        case datePickerIndexPath:
            return isPickerHidden ? 0 : dueDatePickerView.frame.height //Expand or Collapse the Date Picker Cell;
        case notesTextViewIndexPath:
            return largeCellHeight
        default:
            return normalCellHeight
        }
    }

//    ReSet properties for Rows with dueDateLabel and dueDatePickerView:
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath == dateLabelIndexPath {
            isPickerHidden = !isPickerHidden
            dueDateLabel.textColor = isPickerHidden ? .black : tableView.tintColor
            tableView.beginUpdates()
            tableView.endUpdates()
        }
    }
}
