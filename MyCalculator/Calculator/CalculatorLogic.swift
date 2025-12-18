//
//  CalculatorLogic.swift
//  MyCalculator
//
//  Created by Артём on 18.12.2025.
//

import Foundation

class CalculatorLogic {
    private enum Constants {
        static let percentDivider: Double = 100.0
        static let presicion: Double = 1_000_000
    }
    
    private let allSigns: Set<String> = ["=", "+", "-", "x", "÷", "%", "del", "AC"]
    
    func formatResult(_ result: Double) -> String {
        let roundedResult = (result * Constants.presicion).rounded() / Constants.presicion
        var resultString = String(describing: roundedResult)
        
        if resultString.hasSuffix(".0") {
            resultString = String(resultString.dropLast(2))
            return resultString
        } else {
            return resultString.replacingOccurrences(of: ".", with: ",")
        }
    }
    
    func calculateExpression(_ expression: String) -> Double? {
        let procesedExpression = preprocessExpression(expression)
        let mathExpression = NSExpression(format: procesedExpression)
        
        let result = mathExpression.expressionValue(with: nil, context: nil) as? Double
        
        return result
    }
    
    func canAddOperation(_ lastChar: Character) -> Bool {
        return !allSigns.contains(String(lastChar)) || lastChar == "%"
    }
    
    private func preprocessExpression(_ expression: String) -> String {
        
        var expression = expression.replacingOccurrences(of: ",", with: ".")
        expression = expression.replacingOccurrences(of: "x", with: "*")
        expression = expression.replacingOccurrences(of: "÷", with: "/")
        //Need to correct work with float nums
        expression = "1.0 * \(expression)"
        
        expression = preprocessProcents(expression)
        
        return expression
    }
    
    func preprocessProcents(_ expression: String) -> String {
        var result = expression
        //100*20% -> 100*0.2
        result = result.replacingOccurrences(of: "([\\d.]+)\\*([\\d.]+)%", with: "$1*($2/100.0)", options: .regularExpression)
        
        //100 + 20% -> 100*1.2
        result = result.replacingOccurrences(of: "([\\d.])\\+([\\d.]+)%", with: "$1*(1+$2/100.0)", options: .regularExpression)
        
        //100 - 20% -> 100*0.8
        result = result.replacingOccurrences(of: "([\\d.])\\-([\\d.]+)%", with: "$1*(1-$2/100.0)", options: .regularExpression)
        
        //20% -> 0.2
        if result.contains("%") {
            result = result.replacingOccurrences(of: "%", with: "/100.0")
        }
        return result
    }
}

