//
//  CalculateViewModel.swift
//  Calculator
//
//  Created by Gupta, Mrigank on 17/03/17.
//  Copyright © 2017 Gupta, Mrigank. All rights reserved.
//

import Foundation

enum KeyValueOp {
    case NumericKey(String)
    case OperatorKey(String)
    func get()-> String {
        switch self {
        case .NumericKey(let number):
            return number
        case .OperatorKey(let operate):
            return operate
        }
    }
}

enum DisplayKeyPad: Int {
    case
    Devide, Percent, Negate, AllClear,
    Multiply, Nine, Eight, Seven,
    Substract, Six, Five, Four,
    Addition, Three, Two, One,
    Equal, Decimal, Zero
    func display() -> String {
        switch self {
        case .Devide:
            return "÷"
        case .Percent:
            return "%"
        case .Negate:
            return "+/-"
        case .AllClear:
            return "AC"
        case .Multiply:
            return "x"
        case .Nine:
            return "9"
        case .Eight:
            return "8"
        case .Seven:
            return "7"
        case .Substract:
            return "-"
        case .Six:
            return "6"
        case .Five:
            return "5"
        case .Four:
            return "4"
        case .Addition:
            return "+"
        case .Three:
            return "3"
        case .Two:
            return "2"
        case .One:
            return "1"
        case .Equal:
            return "="
        case .Decimal:
            return "."
        case .Zero:
            return "0"
        }
    }
    func pressed() -> KeyValueOp {
        switch self {
        case .Devide:
            return KeyValueOp.OperatorKey("/")
        case .Percent:
            return KeyValueOp.OperatorKey("%")
        case .Negate:
            return KeyValueOp.OperatorKey("-")
        case .AllClear:
            return KeyValueOp.OperatorKey("AC")
        case .Multiply:
            return KeyValueOp.OperatorKey("*")
        case .Nine:
            return KeyValueOp.NumericKey("9")
        case .Eight:
            return KeyValueOp.NumericKey("8")
        case .Seven:
            return KeyValueOp.NumericKey("7")
        case .Substract:
            return KeyValueOp.OperatorKey("-")
        case .Six:
            return KeyValueOp.NumericKey("6")
        case .Five:
            return KeyValueOp.NumericKey("5")
        case .Four:
            return KeyValueOp.NumericKey("4")
        case .Addition:
            return KeyValueOp.OperatorKey("+")
        case .Three:
            return KeyValueOp.NumericKey("3")
        case .Two:
            return KeyValueOp.NumericKey("2")
        case .One:
            return KeyValueOp.NumericKey("1")
        case .Equal:
            return KeyValueOp.OperatorKey("=")
        case .Decimal:
            return KeyValueOp.OperatorKey(".")
        case .Zero:
            return KeyValueOp.NumericKey("0")
        }
    }
}

class CalculateViewModel {
    
    fileprivate var modelOperation:Operation?
    var displayed: String = ""
    var current: Double = 0.0
    
    init() {
        modelOperation = Operation(record: Stack<KeyValueOp>(), operate: Stack<KeyValueOp>(), numeric: Stack<KeyValueOp>())
    }
    public func execute(itemPressed:KeyValueOp) {
        switch itemPressed {
        case .NumericKey(let number):
            print("number pressed \(number)")
            if current == 0.0 {
                displayed.removeAll()
            }
            displayed.append(String(number))
            if let displayValue = Double(displayed) {
                current = displayValue
            }

        case .OperatorKey(let operate):
            print("operator pressed \(operate)")
            handleOperator(operate)
        }
        print("displayed number \(displayed)")
        print("resultant number \(current)")
    }
    
}

private extension CalculateViewModel {
    
    func handleOperator(_ operatorPressed:String) {
        displayed.removeAll()
        // current operator x/÷, handling operator presidence
        if !(operatorPressed == "+" || operatorPressed == "-") && (operatorPressed == "*" || operatorPressed == "/") {
            if let lastOperatorString = modelOperation?.operate?.topItem?.get() {
                print("lastOperatorString \(lastOperatorString)")
                if lastOperatorString == "*" || lastOperatorString == "/" {
                    arthmaticOperation(arthOp: (modelOperation?.operate?.pop().get())!, lastNumber: Double((modelOperation?.numeric?.pop().get())!)!)
                }
                // previous is +/- and current operator x/÷
                pushOperatorAndUpdateResult(operatorPressed)
                return
            }
        }
        // empty stacks for calculation, if presidence is not an issue
        equate()
        pushOperatorAndUpdateResult(operatorPressed)
    }
    
    func arthmaticOperation(arthOp:String, lastNumber:Double) {
        switch arthOp {
        case "*":
            current = lastNumber * current
        case "/":
            current = lastNumber / current
        case "-":
            current = lastNumber - current
        case "+":
            current = lastNumber + current
        default:
            break
        }
    }
    func pushOperatorAndUpdateResult(_ operatorPressed:String) {
        modelOperation?.operate?.push(.OperatorKey(operatorPressed))
        print("operator pushed ...............\(operatorPressed)")
        modelOperation?.numeric?.push(.NumericKey(String(current)))
        print("numeric pushed ...............\(current)")
        displayed.append(String(current))
        current = 0.0
    }
    func equate() {
        while (modelOperation?.numeric?.topItem) != nil && modelOperation?.operate?.topItem != nil {
            arthmaticOperation(arthOp: (modelOperation?.operate?.pop().get())!, lastNumber: Double((modelOperation?.numeric?.pop().get())!)!)
        }
    }
}
