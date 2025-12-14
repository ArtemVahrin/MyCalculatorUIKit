//
//  ViewController.swift
//  MyCalculator
//
//  Created by Артём on 09.12.2025.
//

import UIKit

class ViewController: UIViewController {
    
    let displayLabel: UILabel = {
        $0.textAlignment = .right
        $0.text = ""
        $0.font = .systemFont(ofSize: 40)
        return $0
    }(UILabel())
    
    let verticalStack1: UIStackView = {
        $0.axis = .vertical
        $0.distribution = .fillEqually
        $0.spacing = 10
        return $0
    }(UIStackView())
    
    let allLabelsByLinesArray: [[String]] = [["+/-","0",",", "="], ["1", "2", "3", "+"],[ "4", "5", "6", "-"], ["7", "8", "9", "*"],[ "del", "AC", "%", "/" ]]
    let allSigns: [String] = ["=","+","-","*","/","%", "del", "AC"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

        view.addSubview(verticalStack1)
        view.addSubview(displayLabel)
        
        createAllButtons(from: allLabelsByLinesArray)
        

//        if allSigns.contains(inputAndOutputLabel.text?.last) {
//        }
        
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
    
//    func clearButton(_ button: UIButton) {
//        if button.currentTitle == "del" {
//            if displayLabel.text != "" {
//                displayLabel.text!.removeLast()
//            } else {
//                displayLabel.text! = ""
//            }
//        }
//    }
    
    func createButton(with sign: String, tag: Int) -> UIButton {
        let button = UIButton()
        button.backgroundColor = allSigns.contains(sign) ? .red : .gray
        button.layer.cornerRadius = 8
        button.setTitle(sign, for: .normal)
        button.tag = tag
        button.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
        return button
    }

    @objc func buttonPressed(_ sender: UIButton) {
//        let allLabelsByLinesArray: [[String]] = [["+/-","0",",", "="], ["1", "2", "3", "+"],[ "4", "5", "6", "-"], ["7", "8", "9", "*"],[ "del", "AC", "%", "/" ]]
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
//            plusMinusPressed()
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
            case 15: operationPressed("*")
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
        
    }
    
    func commaPressed() {
        if displayLabel.text != nil {
            displayLabel.text! += ","
        }
    }
    func deleteLastPressed() {
        if ((displayLabel.text) != nil) && displayLabel.text != "" {
            displayLabel.text?.removeLast()
        }
    }
    
    func clearAllPressed() {
        displayLabel.text = ""
    }

    private func setConstraints() {
        verticalStack1.translatesAutoresizingMaskIntoConstraints = false
        displayLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            displayLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            displayLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            displayLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            displayLabel.heightAnchor.constraint(equalToConstant: 200),
            
            verticalStack1.topAnchor.constraint(equalTo: displayLabel.bottomAnchor, constant: 20),
            verticalStack1.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            verticalStack1.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            verticalStack1.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 20)
        ])
    }

}

