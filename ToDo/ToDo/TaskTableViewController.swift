//
//  TaskTableViewController.swift
//  ToDo
//
//  Created by William Caruso on 1/23/18.
//  Copyright © 2018 wcaruso. All rights reserved.
//

import UIKit


class TaskTableViewController: UITableViewController {

    private var todoItems = ToDoItem.getMockData()

    private func addNewToDoItem(title: String) {
        let newIndex = todoItems.count
        todoItems.append(ToDoItem(title: title))
        tableView.insertRows(at: [IndexPath(row: newIndex, section: 0)], with: .top)
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todoItems.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "task_cell", for: indexPath) as? TaskTableViewCell
        let todo = todoItems[indexPath.row]
        if todo.done {
            let attributeString: NSMutableAttributedString =  NSMutableAttributedString(string: todo.title)
            attributeString.addAttribute(NSAttributedStringKey.strikethroughStyle, value: 2, range: NSMakeRange(0, attributeString.length))
            cell?.task.attributedText = attributeString
        } else {
            cell?.task.text = todo.title
        }
        return cell!
    }
    
    // MARK: - Table view delegate
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if indexPath.row < todoItems.count {
            todoItems.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .top)
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row < todoItems.count {
            todoItems[indexPath.row].done = true
            tableView.reloadData()
        }
    }
    
    // MARK: - Navigation

    @IBAction func unwindFromAddTaskVC(_ sender: UIStoryboardSegue) {
        if sender.source is AddTaskViewController {
            if let senderVC = sender.source as? AddTaskViewController {
                todoItems.append(ToDoItem(title: senderVC.task))
                tableView.reloadData()
            }
        }
    }
 

}
