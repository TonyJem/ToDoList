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


    }
    
    
//    MARK: - Outlets:
    @IBOutlet var titleTextField: UITextField!
    @IBOutlet var isCompleteButton: UIButton!
    @IBOutlet var dueDateLabel: UILabel!
    @IBOutlet var dueDatePickerView: UIDatePicker!
    @IBOutlet var notesTextView: UITextView!
}
