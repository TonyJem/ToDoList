//
//  ToDoDetailTableViewController.swift
//  ToDoList
//
//  Created by Office-iMac on 2020-05-21.
//  Copyright © 2020 Tony Jem. All rights reserved.
//

import UIKit

class ToDoDetailTableViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateSaveButtonState()
    }

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

    //    MARK: - Dismiss Keyboard on Return:
    @IBAction func returnPressed(_ sender: UITextField) {
        titleTextField.resignFirstResponder()
    }

    //    MARK: - Outlets:
    @IBOutlet var titleTextField: UITextField!
    @IBOutlet var isCompleteButton: UIButton!
    @IBOutlet var dueDateLabel: UILabel!
    @IBOutlet var dueDatePickerView: UIDatePicker!
    @IBOutlet var notesTextView: UITextView!
}
