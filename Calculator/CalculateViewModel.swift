//
//  CalculateViewModel.swift
//  Calculator
//
//  Created by Gupta, Mrigank on 17/03/17.
//  Copyright © 2017 Gupta, Mrigank. All rights reserved.
//

import Foundation

enum KeyValueOp {
    case NumericKey(Int)
    case OperatorKey(String)
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
            return KeyValueOp.NumericKey(9)
        case .Eight:
            return KeyValueOp.NumericKey(8)
        case .Seven:
            return KeyValueOp.NumericKey(7)
        case .Substract:
            return KeyValueOp.OperatorKey("-")
        case .Six:
            return KeyValueOp.NumericKey(6)
        case .Five:
            return KeyValueOp.NumericKey(5)
        case .Four:
            return KeyValueOp.NumericKey(4)
        case .Addition:
            return KeyValueOp.OperatorKey("+")
        case .Three:
            return KeyValueOp.NumericKey(3)
        case .Two:
            return KeyValueOp.NumericKey(2)
        case .One:
            return KeyValueOp.NumericKey(1)
        case .Equal:
            return KeyValueOp.OperatorKey("=")
        case .Decimal:
            return KeyValueOp.OperatorKey(".")
        case .Zero:
            return KeyValueOp.NumericKey(0)
        }
    }
}

class CalculateViewModel {
    
    fileprivate var modelOperation:Operation?
    var displayed:Double?
    
    public func execute(itemPressed:KeyValueOp) {
        switch itemPressed {
        case .NumericKey(let number):
            print("number pressed \(number)")
//            operatorNumeric(itemPressed)
        case .OperatorKey(let arthOperator):
            print("operator pressed \(arthOperator)")
        }
    }
    
}

//private extension CalculateViewModel {
//    func operatorNumeric(_ itemPressed:KeyValueOp) {
//        
//        let lastElement:KeyValueOp? = modelOperation?.operate?.topItem
//
//        switch lastElement {
//        case .NumericKey(let number):
//            if let popped = modelOperation?.operate?.popSafe() {
//                popped
//            }
//        case .OperatorKey(let arthOperator):
//          
//        }
//    }
//}
