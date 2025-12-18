//
//  ButtonType.swift
//  MyCalculator
//
//  Created by Артём on 18.12.2025.
//

import UIKit

enum CalculatorButtonType {
    case number(String)
    case operation(String)
    case percent
    case comma
    case delete
    case clearAll
    case plusMinus
    case equals
    
    var title: String {
        switch self {
        case .number(let number):
            return number
        case .operation(let operation):
            return operation
        case .percent:
            return "%"
        case .comma:
            return ","
        case .delete:
            return "del"
        case .clearAll:
            return "AC"
        case .plusMinus:
            return "+/-"
        case .equals:
            return "="
        }
    }
    
    var backgroundColor: UIColor {
        switch self {
        case .number(_), .comma, .plusMinus: return .gray
        default: return .systemRed
        }
    }
    
    var tag: Int {
        
        switch self {
        case .plusMinus: return 0
        case .comma: return 2
        case .equals: return 3
        case .number("0"): return 1
            
        case .number("1"): return 4
        case .number("2"): return 5
        case .number("3"): return 6
        case .operation("+"): return 7
            
        case .number("4"): return 8
        case .number("5"): return 9
        case .number("6"): return 10
        case .operation("-"): return 11
            
        case .number("7"): return 12
        case .number("8"): return 13
        case .number("9"): return 14
        case .operation("x"): return 15
            
        case .delete: return 16
        case .clearAll: return 17
        case .percent: return 18
        case .operation("÷"): return 19
        
        default: return -1
        }
    }
    
    static let buttonLayout: [[CalculatorButtonType]] = [
        [.plusMinus, .number("0"), .comma, .equals],
        [.number("1"), .number("2"), .number("3"), .operation("+")],
        [.number("4"), .number("5"), .number("6"), .operation("-")],
        [.number("7"), .number("8"), .number("9"), .operation("x")],
        [.delete, .clearAll, .percent, .operation("÷")]
    ]
}
