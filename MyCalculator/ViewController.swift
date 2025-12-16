//
//  ViewController.swift
//  MyCalculator
//
//  Created by Артём on 09.12.2025.
//

import UIKit
import Foundation

class ViewController: UIViewController {
    
    private let displayLabel: UILabel = {
        $0.textAlignment = .right
        $0.text = "0"
        $0.font = .systemFont(ofSize: 40)
        return $0
    }(UILabel())
    
    private let answerLabel: UILabel = {
        $0.text = ""
        $0.font = .systemFont(ofSize: 20)
        $0.textColor = .lightGray
        $0.textAlignment = .right
        return $0
    }(UILabel())
    
    private let verticalStack1: UIStackView = {
        $0.axis = .vertical
        $0.distribution = .fillEqually
        $0.spacing = 10
        return $0
    }(UIStackView())
    
    private let answerLabelScrollView: UIScrollView = {
        $0.showsHorizontalScrollIndicator = false
        $0.alwaysBounceHorizontal = true
        $0.semanticContentAttribute = .forceRightToLeft
        return $0
    }(UIScrollView())
    
    private let displayLabelScrollView: UIScrollView = {
        $0.showsHorizontalScrollIndicator = false
        $0.alwaysBounceHorizontal = true
        $0.semanticContentAttribute = .forceRightToLeft
        return $0
    }(UIScrollView())
    
    private let allLabelsByLinesArray: [[String]] = [["+/-","0",",", "="], ["1", "2", "3", "+"],["4", "5", "6", "-"], ["7", "8", "9", "x"],[ "del", "AC", "%", "/" ]]
    private let allSigns: [String] = ["=","+","-","x","/","%", "del", "AC"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        view.addSubview(answerLabelScrollView)
        view.addSubview(displayLabelScrollView)
        view.addSubview(verticalStack1)
        view.addSubview(displayLabel)
        
        answerLabelScrollView.addSubview(answerLabel)
        displayLabelScrollView.addSubview(displayLabel)
        
        createAllButtons(from: allLabelsByLinesArray)
        
        setConstraints()
    }
    
    func createStack(from buttons: [UIButton]) -> UIStackView {
        let horizontalStack: UIStackView = {
            $0.axis = .horizontal
            $0.distribution = .fillEqually
            $0.spacing = 10
            return $0
        }(UIStackView())
        
        for button in buttons {
            horizontalStack.addArrangedSubview(button)
        }
        
        return horizontalStack
    }
    
    func createAllButtons(from allLabelsByLinesArray: [[String]]) {
        var allButtonsArrays = [[UIButton]]()
        var line = [UIButton]()
        var tag = 0
        for labelLine in allLabelsByLinesArray {
            line = []
            for buttonLabel in labelLine {
                line.append(createButton(with: buttonLabel, tag: tag))
                tag += 1
            }
            allButtonsArrays.append(line)
            
        }
        
        for buttonLine in allButtonsArrays.reversed() {
            let stack = createStack(from: buttonLine)
            verticalStack1.addArrangedSubview(stack)
        }
    }
    
    func createButton(with sign: String, tag: Int) -> UIButton {
        let button = UIButton()
        button.backgroundColor = allSigns.contains(sign) ? .red : .gray
        button.layer.cornerRadius = 8
        button.setTitle(sign, for: .normal)
        button.titleLabel?.font = UIFont(descriptor: UIFontDescriptor(), size: 24)
        button.tag = tag
        button.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
        return button
    }
    
    @objc func buttonPressed(_ sender: UIButton) {
        if displayLabel.text == "0" {
            displayLabel.text = ""
        }
        //move expression from left to right
        scrollToRightEnd()
        
        sender.startAnimatingPressAction()
        let tag = sender.tag
        
        //tag for nums
        if tag == 1 || (tag >= 4 && tag <= 6) || (tag >= 8 && tag <= 10) || (tag >= 12 && tag <= 14) {
            switch tag {
            case 1: numberPressed(String(0))
            case 4: numberPressed(String(1))
            case 5: numberPressed(String(2))
            case 6: numberPressed(String(3))
            case 8: numberPressed(String(4))
            case 9: numberPressed(String(5))
            case 10: numberPressed(String(6))
            case 12: numberPressed(String(7))
            case 13: numberPressed(String(8))
            case 14: numberPressed(String(9))
            default:
                print("WrongNumber")
            }
        }
        // plus/minus button
        if tag == 0 {
            plusMinusPressed()
        }
        //comma tag
        if tag == 2 {
            commaPressed()
        }
        //operations tags
        if tag == 7 || tag == 11 || tag == 15 || tag == 19 {
            
            switch tag {
            case 7: operationPressed("+")
            case 11: operationPressed("-")
            case 15: operationPressed("x")
            case 19: operationPressed("/")
            default:
                print("operation error")
            }
            
        }
        //equal  tag
        if tag == 3 {
            equalPressed()
        }
        // del tag
        if tag == 16 {
            deleteLastPressed()
        }
        //AC tag
        if tag == 17 {
            clearAllPressed()
        }
    }
    
    func plusMinusPressed() {
        
    }
    
    func numberPressed(_ number: String) {
        displayLabel.text! += number
    }
    
    func operationPressed(_ operation: String) {
        if let lastSign = displayLabel.text?.last {
            if !allSigns.contains(String(lastSign)) {
                displayLabel.text! += operation
            }
        }
    }
    
    func equalPressed() {
        answerLabel.text = displayLabel.text
        
        guard let string = displayLabel.text else { return }
        
        var expression = string.replacingOccurrences(of: ",", with: ".")
        expression = expression.replacingOccurrences(of: "x", with: "*")
        expression = "1.0 * \(expression)"
        
        let mathExpression = NSExpression(format: expression)
        
        guard let result = mathExpression.expressionValue(with: nil, context: nil) as? Double else { return }
        
        clearResults(result)
    }
    
    func commaPressed() {
        if displayLabel.text != nil {
            displayLabel.text! += ","
        }
    }
    func deleteLastPressed() {
        answerLabel.text = ""
        
        if ((displayLabel.text) != nil) && displayLabel.text != "" {
            displayLabel.text?.removeLast()
        }
        if displayLabel.text == "" {
            displayLabel.text = "0"
        }
    }
    
    func clearAllPressed() {
        displayLabel.text = "0"
        answerLabel.text = ""
    }
    
    func clearResults(_ result: Double) {
        var resultString = String(result)
        var ans = ""
        
        if resultString.last == "0" {
            resultString.removeLast()
            resultString.removeLast()
            ans = resultString
        } else {
            ans = resultString.replacingOccurrences(of: ".", with: ",")
        }
        
        displayLabel.text = ans
    }
    
    func scrollToRightEnd() {
        let contentWidth = displayLabelScrollView.contentSize.width
        let scrollViewWidth = displayLabelScrollView.bounds.width
        
        if contentWidth > scrollViewWidth {
            let offsetX = contentWidth - scrollViewWidth
            displayLabelScrollView.setContentOffset(CGPoint(x: offsetX, y: 0), animated: true)
        } else {
            displayLabelScrollView.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
        }
    }
    
    private func setConstraints() {
        verticalStack1.translatesAutoresizingMaskIntoConstraints = false
        displayLabel.translatesAutoresizingMaskIntoConstraints = false
        answerLabel.translatesAutoresizingMaskIntoConstraints = false
        answerLabelScrollView.translatesAutoresizingMaskIntoConstraints = false
        displayLabelScrollView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            
            answerLabelScrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            answerLabelScrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            answerLabelScrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 130),
            answerLabelScrollView.heightAnchor.constraint(equalToConstant: 50),
            
            answerLabel.leadingAnchor.constraint(equalTo: answerLabelScrollView.leadingAnchor, constant: 20),
            answerLabel.trailingAnchor.constraint(equalTo: answerLabelScrollView.trailingAnchor, constant: -20),
            answerLabel.topAnchor.constraint(equalTo: answerLabelScrollView.topAnchor),
            answerLabel.bottomAnchor.constraint(equalTo: answerLabelScrollView.bottomAnchor),
            answerLabel.heightAnchor.constraint(equalTo: answerLabelScrollView.heightAnchor),
            
            displayLabelScrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            displayLabelScrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            displayLabelScrollView.topAnchor.constraint(equalTo: answerLabelScrollView.bottomAnchor),
            displayLabelScrollView.heightAnchor.constraint(equalToConstant: 50),
            
            displayLabel.leadingAnchor.constraint(equalTo: displayLabelScrollView.leadingAnchor, constant: 20),
            displayLabel.trailingAnchor.constraint(equalTo: displayLabelScrollView.trailingAnchor, constant: -20),
            displayLabel.topAnchor.constraint(equalTo: displayLabelScrollView.topAnchor),
            displayLabel.bottomAnchor.constraint(equalTo: displayLabelScrollView.bottomAnchor),
            displayLabel.heightAnchor.constraint(equalTo: displayLabelScrollView.heightAnchor),
            
            verticalStack1.topAnchor.constraint(equalTo: displayLabel.bottomAnchor, constant: 20),
            verticalStack1.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            verticalStack1.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            verticalStack1.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 20)
        ])
    }
    
    
    
}
