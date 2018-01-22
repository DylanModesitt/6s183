//
//  ViewController.swift
//  Calculator
//
//  Created by Dylan Modesitt on 1/21/18.
//  Copyright © 2018 modesitt. All rights reserved.
//

import UIKit

class ViewController: UIViewController {


    // MARK: - Properties
    @IBOutlet weak var display: UILabel!
    @IBOutlet var clearButton: UIButton!
    
    private var userIsTyping = false
    private var model = Model()
    
    var displayValue: Double {
        get {
            return Double(display.text!)!
        } set {
            display.text = String(newValue)
        }
    }
    
    @IBAction func clear(_ sender: UIButton) {
        
        let clearText = clearButton.currentTitle!
        
        if clearText == "C" {
            display.text = ""
            clearButton.setTitle("AC", for: .normal)
            print("changed")
        } else if clearText == "AC" {
            display.text = ""
            model.clear()
        }
        
    }
    
    @IBAction func touchDigit(_ sender: UIButton) {
        
        let digit = sender.currentTitle!
        clearButton.setTitle("C", for: .normal)

        if userIsTyping {
            let textCurrentlyInDisplay = display.text!
            display.text = textCurrentlyInDisplay + digit
        } else {
            display.text = digit
            userIsTyping = true
        }
        
    }
    
    @IBAction func performOperation(_ sender: UIButton) {
        
        if userIsTyping {
            model.setOperand(displayValue)
            userIsTyping = false
        }
        
        if let mathematicalSymbol = sender.currentTitle {
            model.performOperation(mathematicalSymbol)
        }
        
        if let result = model.result {
            displayValue = result
        }
        
    }
    
    
    // MARK: - View Controller Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

}

