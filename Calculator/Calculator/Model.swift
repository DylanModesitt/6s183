//
//  Model.swift
//  Calculator
//
//  Created by Dylan Modesitt on 1/21/18.
//  Copyright © 2018 modesitt. All rights reserved.
//

import Foundation


struct Model {
    
    private var accumulator: Double?
    private var operations: Dictionary<String, Operation> = [
        "π" : Operation.constant(Double.pi),
        "√" : Operation.unaryOperation(sqrt),
        "%" : Operation.unaryOperation({ $0 / 100 }),
        "±" : Operation.unaryOperation({ -$0 }),
        "+" : Operation.binaryOperation({ $0 + $1 }),
        "-" : Operation.binaryOperation({ $0 - $1 }),
        "×" : Operation.binaryOperation({ $0 * $1 }),
        "/" : Operation.binaryOperation({ $0 / $1 }),
        "=" : Operation.equals
    ]
    
    private var pendingBinaryOperation: PendingBinaryOperation?
    
    private enum Operation {
        case constant(Double)
        case unaryOperation((Double) -> Double)
        case binaryOperation((Double, Double) -> Double)
        case equals
    }
    
    private struct PendingBinaryOperation {
        let function: (Double, Double) -> Double
        let firstOperand: Double
        
        func perform(with secondOperand: Double) -> Double {
            return function(firstOperand, secondOperand)
        }
    }
    
    var result: Double? {
        get {
            return accumulator
        }
    }
    
    private mutating func performPendingBinaryOperation() {
        if pendingBinaryOperation != nil && accumulator != nil {
            accumulator = pendingBinaryOperation!.perform(with: accumulator!)
            pendingBinaryOperation = nil
        }
    }
    
    mutating func performOperation(_ symbol: String) {
        
        if let operation = operations[symbol] {
            switch operation {
            case .constant(let value):
                accumulator = value
            case .unaryOperation(let function):
                if accumulator != nil {
                    accumulator = function(accumulator!)
                }
            case .binaryOperation(let function):
                if accumulator != nil {
                    pendingBinaryOperation = PendingBinaryOperation(function: function, firstOperand: accumulator!)
                    accumulator = nil
                }
            case .equals:
                performPendingBinaryOperation()
            }
        }
        
    }
    
    mutating func setOperand(_ operand: Double) {
        accumulator = operand
    }
    
    mutating func clear() {
        accumulator = nil
        pendingBinaryOperation = nil
    }
    
}
