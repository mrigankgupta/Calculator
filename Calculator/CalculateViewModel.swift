//
//  CalculateViewModel.swift
//  Calculator
//
//  Created by Gupta, Mrigank on 17/03/17.
//  Copyright © 2017 Gupta, Mrigank. All rights reserved.
//

import Foundation

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
    func pressed()-> String {
        switch self {
        case .Devide:
            return "/"
        case .Percent:
            return "%"
        case .Negate:
            return "+/-"
        case .AllClear:
            return "AC"
        case .Multiply:
            return "*"
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
    func isNumber()-> Bool {
        switch self {
        case .Zero, .One, .Two, .Three, .Four, .Five, .Six, .Seven, .Eight, .Nine:
            return true
        case .Devide, .Percent, .Negate, .AllClear, .Multiply, .Substract, .Addition, .Equal, .Decimal:
            return false
        }
    }
}

class CalculateViewModel {
    
    fileprivate var modelOperation: Operation?
    fileprivate var currentNumber: Double = 0.0
    fileprivate var lastKeyPressed: DisplayKeyPad?
    var displayed: String = ""

    init() {
        modelOperation = Operation(record: Stack<String>(), operate: Stack<String>(), numeric: Stack<String>())
    }
    
    public func execute(itemPressed:DisplayKeyPad) {
        switch itemPressed {
        case .Zero, .One, .Two, .Three, .Four, .Five, .Six, .Seven, .Eight, .Nine:
            print("number pressed \(itemPressed.pressed())")
            if let isLastKeyNum = lastKeyPressed?.isNumber() {
                if !isLastKeyNum && lastKeyPressed != DisplayKeyPad.Decimal {
                    displayed.removeAll()
                }
            }
            display(itemPressed.pressed())
            
        case .Devide, .Percent, .Negate, .AllClear, .Multiply, .Substract, .Addition, .Equal, .Decimal:
            print("operator pressed \(itemPressed.pressed())")
            handleOperator(itemPressed)
        }
        lastKeyPressed = itemPressed
        print("displayed number \(displayed)")
        print("resultant number \(currentNumber)")
    }
}

private extension CalculateViewModel {
    
    func handleOperator(_ operatorPressed:DisplayKeyPad) {
        if let displayValue = Double(displayed) {
            currentNumber = displayValue
        }
        if operatorPressed == .AllClear {
            allClear()
        }else if operatorPressed == .Equal {
            equate()
            displayed.removeAll()
            display(String(currentNumber))
            currentNumber = 0.0
        }else if operatorPressed == .Decimal && !displayed.contains(".") {
            display(".")
        }else if operatorPressed == .Negate && currentNumber*currentNumber >= 0.0 {
            currentNumber = -currentNumber;
        }else if operatorPressed == .Percent && currentNumber*currentNumber >= 0.0 {
            currentNumber = currentNumber / 100.0
        }else {
            displayed.removeAll()
            // current operator x/÷, handling operator presidence
            if !(operatorPressed == .Addition || operatorPressed == .Substract) && (operatorPressed == .Multiply || operatorPressed == .Devide) {
                // if there is a last operator
                if let lastOperatorString = modelOperation?.operate?.topItem {
                    print("lastOperatorString \(lastOperatorString)")
                    if lastOperatorString == DisplayKeyPad.Multiply.pressed()
                        || lastOperatorString == DisplayKeyPad.Devide.pressed() {
                        arthmaticOperation(arthOp: (modelOperation?.operate?.pop())!, lastNum: Double((modelOperation?.numeric?.pop())!)!)
                    }
                    // previous is +/- and current operator x/÷
                    pushOperatorAndUpdateResult(operatorPressed.pressed())
                    return
                }
            }
            // empty stacks for calculation, if presidence is not an issue
            equate()
            pushOperatorAndUpdateResult(operatorPressed.pressed())
        }
    }
    
    func arthmaticOperation(arthOp:String, lastNum:Double) {
        switch arthOp {
        case "*":
            currentNumber = lastNum * currentNumber
        case "/":
            currentNumber = lastNum / currentNumber
        case "-":
            currentNumber = lastNum - currentNumber
        case "+":
            currentNumber = lastNum + currentNumber
        default:
            break
        }
    }
    
    func pushOperatorAndUpdateResult(_ operatorPressed:String) {
        
        modelOperation?.operate?.push(operatorPressed)
        let numString = String(currentNumber)
        modelOperation?.numeric?.push(numString)
        
        modelOperation?.record?.push(operatorPressed)
        modelOperation?.record?.push(numString)
        
        print("operator pushed ...............\(operatorPressed)")
        print("numeric pushed ...............\(numString)")
        
        display(numString)
    }
    
    func equate() {
        while (modelOperation?.numeric?.topItem) != nil && modelOperation?.operate?.topItem != nil {
            arthmaticOperation(arthOp: (modelOperation?.operate?.pop())!, lastNum: Double((modelOperation?.numeric?.pop())!)!)
        }
    }
    func allClear() {
        currentNumber = 0.0
        displayed.removeAll()
        modelOperation?.numeric?.empty()
        modelOperation?.operate?.empty()
    }
    func display(_ item: String) {
        if let number = Double(item) {
            if number*number - Double(Int(number*number)) > 0 {
                displayed.append(String(number))
            }else {
                displayed.append(String(Int(number)))
            }
        }else {
            displayed.append(item)
        }
    }
}
