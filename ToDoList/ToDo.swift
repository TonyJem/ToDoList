//
//  ToDo.swift
//  ToDoList
//
//  Created by Office-iMac on 2020-05-20.
//  Copyright © 2020 Tony Jem. All rights reserved.
//

import Foundation

struct ToDo{
    var title: String
    var isComplite: Bool
    var dueDate: Date
    var notes: String?
    
//    Load data from file:
    static func loadToDos() -> [ToDo]? {
        return nil
    }
    
//    Load sample data from array below:
    static func loadSampleToDos() -> [ToDo] {
        let todo1 = ToDo(title: "ToDo One", isComplite: false, dueDate: Date(), notes: "Notes 1")
        let todo2 = ToDo(title: "ToDo Two", isComplite: false, dueDate: Date(), notes: "Notes 2")
        let todo3 = ToDo(title: "ToDo Three", isComplite: false, dueDate: Date(), notes: "Notes 3")
        return [todo1, todo2, todo3]
    }
}