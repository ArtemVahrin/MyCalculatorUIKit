//
//  ViewController.swift
//  MyCalculator
//
//  Created by Артём on 09.12.2025.
//

import UIKit

class ViewController: UIViewController {

    let inputAndOutputLabel: UILabel = {
        $0.textAlignment = .right
        $0.text = ""
        $0.font = .systemFont(ofSize: 30)
        return $0
    }(UILabel())
    
    let verticalStack1: UIStackView = {
        $0.axis = .vertical
        $0.distribution = .fillEqually
        $0.spacing = 10
    return $0
    }(UIStackView())

    let allLabelsByLinesArray: [[String]] = [["+/-","0",",", "="], ["1", "2", "3", "+"],[ "4", "5", "6", "-"], ["7", "8", "9", "*"],[ "del", "AC", "%", "/" ]]
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

        view.addSubview(verticalStack1)
        view.addSubview(inputAndOutputLabel)
        var allButtonsArrays = [[UIButton]]()
        var line = [UIButton]()
        
        for labelLine in allLabelsByLinesArray {
            line = []
            for buttonLabel in labelLine {
                line.append(createButton(with: buttonLabel))
            }
            allButtonsArrays.append(line)
            
        }
        
        for buttonLine in allButtonsArrays {
            let stack = createStack(from: buttonLine)
            verticalStack1.addArrangedSubview(stack)
        }
        
//        for button in allButtons {
//            if numsButtons.contains(button) {
//                button.backgroundColor = .lightGray
//            } else if button.currentTitle == "=" {
//                button.addTarget(self, action: #selector(mathOperation), for: .touchUpInside)
//            }
//            else {
//                button.backgroundColor = .red
//            }
//            button.addTarget(self, action: #selector(printButtonTapped), for: .touchUpInside)
//            button.layer.cornerRadius = 8
//
//        }
//        
        
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
    
    func createAllButtons() {
        
    }
    @objc func printButtonTapped(_ button: UIButton) {
        if button.currentTitle == "del"{
            if inputAndOutputLabel.text != "" {
                inputAndOutputLabel.text!.removeLast()
            } else {
                inputAndOutputLabel.text! = ""
            }
        }  else if button.currentTitle == "AC" {
            inputAndOutputLabel.text! = ""
        } else {
            inputAndOutputLabel.text! += button.currentTitle ?? "-77"
        }
    }
    
    
    @objc func mathOperation(_ str: String) -> String {
        var ans = ""
        
        return ans
    }
    
    func createButton(with sign: String) -> UIButton {
        let button = UIButton()
        button.backgroundColor = .gray
        button.setTitle(sign, for: .normal)
        return button
    }

    private func setConstraints() {
        verticalStack1.translatesAutoresizingMaskIntoConstraints = false
        inputAndOutputLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            inputAndOutputLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            inputAndOutputLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            inputAndOutputLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            inputAndOutputLabel.heightAnchor.constraint(equalToConstant: 200),
            
            verticalStack1.topAnchor.constraint(equalTo: inputAndOutputLabel.bottomAnchor, constant: 20),
            verticalStack1.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            verticalStack1.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            verticalStack1.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 20)
        ])
    }

}

