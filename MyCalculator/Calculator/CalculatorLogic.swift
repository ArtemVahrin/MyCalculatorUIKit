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
    //TODO: Need to Refactor
    func changeSign(_ expression: String) -> String {
        var expression = expression
        
        if let lastChar = expression.last{
            if isExpressionContainsOperations(expression) == false {
                expression = addParenthesesToBeginning(in: expression)
            } else if isExpressionContainsOperations(expression) == false && expression.hasSuffix(")") {
                expression = expression.replacingNegativeNumberWithPositive()
            } else {
                if canAddOperation(lastChar) && !expression.hasSuffix(")") {
                    expression = addParentheses(in: expression)
                } else if expression.hasSuffix(")") {
                    expression = expression.replacingNegativeNumberWithPositive()
                }
            }
            
        }
        return expression
    }
    
    private func isExpressionContainsOperations(_ expression: String) -> Bool {
        for char in expression {
            if allSigns.contains(String(char)) {
                return true
            }
        }
        return false
    }
    
    private func addParentheses(in expression: String) -> String {
        var expression = expression
        
        for (index,char) in expression.enumerated().reversed() {
            if allSigns.contains(String(char)) {
                expression.insert(contentsOf: "(-", at: String.Index(utf16Offset: index + 1, in: expression))
                expression.append(")")
                
                break
            }
        }
        return expression
    }
    
    private func addParenthesesToBeginning(in expression: String) -> String {
        var expression = expression
    
        expression.insert(contentsOf: "(-", at: String.Index(utf16Offset: 0, in: expression))
        expression.append(")")
        
        return expression
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
    //TODO: incorrectly calculates percents with negative numbers
    private func preprocessProcents(_ expression: String) -> String {
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

extension String {
    func replacingNegativeNumberWithPositive() -> String {
        let pattern = "\\(-([\\d.]+)\\)"
        
        guard let regex = try? NSRegularExpression(pattern: pattern),
              let lastMatch = regex.matches(in: self,
                                            range: NSRange(self.startIndex..., in: self)).last,
              let range = Range(lastMatch.range, in: self) else {
            return self
        }
        var result = self
        
        let negativeNumber = String(self[range])
        let positiveNumber = negativeNumber
            .replacingOccurrences(of: "[()]", with: "", options: .regularExpression)
            .replacingOccurrences(of: "^--?", with: "", options: .regularExpression)
        
        result.replaceSubrange(range, with: positiveNumber)
        print(negativeNumber, result)
        return result
    }
}
