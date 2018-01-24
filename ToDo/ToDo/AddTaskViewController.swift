//
//  AddTaskViewController.swift
//  ToDo
//
//  Created by William Caruso on 1/23/18.
//  Copyright © 2018 wcaruso. All rights reserved.
//

import UIKit

class AddTaskViewController: UIViewController {

    var task:String = ""
    
    // MARK: - Outlets
    @IBOutlet weak var taskTextView: UITextView!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var addTaskButton: UIButton!
    
    // MARK: - Actions
    @IBAction func cancel(_ sender: Any) {
        dismiss(animated: true)
        taskTextView.resignFirstResponder()
    }
    @IBAction func addTask(_ sender: Any) {
        dismiss(animated: true)
        taskTextView.resignFirstResponder()
    }
    
    
    // MARK: - Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        cancelButton.contentHorizontalAlignment = .right
        addTaskButton.layer.cornerRadius = 10
    }

    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let newTask = taskTextView.text {
            task = newTask
        }
    }

}

extension AddTaskViewController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.text == "Say something..." {
            taskTextView.text.removeAll()
            taskTextView.textColor = .white
        }
    }
    
}

