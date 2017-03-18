//
//  CalculateViewModel.swift
//  Calculator
//
//  Created by Gupta, Mrigank on 17/03/17.
//  Copyright © 2017 Gupta, Mrigank. All rights reserved.
//

import Foundation

enum DispalyKeyPad: Int {
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
}

class CalculateViewModel {
    
    enum KeyValue {
        case NumberKey(Int)
        case OperatorKey(String)
    }
    
    
    
    func execute(itemPressed:KeyValue) {
        
        switch itemPressed {
        case .NumberKey(let number):
            print("number pressed \(number)")
        case .OperatorKey(let arthOperator):
            print("operator pressed \(arthOperator)")
        }
    }
    
}
