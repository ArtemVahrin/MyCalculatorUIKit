//
//  ViewController.swift
//  MyCalculator
//
//  Created by Артём on 09.12.2025.
//

import UIKit

class ViewController: UIViewController {

    let inputAndOutputLabel: UILabel = {
        $0.backgroundColor = .green
        return $0
    }(UILabel())
    
    let verticalStack1: UIStackView = {
        $0.axis = .vertical
        $0.distribution = .fillEqually
        $0.spacing = 10
    return $0
    }(UIStackView())
    
    let numButton0: UIButton = {
        $0.setTitle("0", for: .normal)
        $0.backgroundColor = .red
        return $0
    }(UIButton())
    
    let numButton1: UIButton = {
        $0.setTitle("1", for: .normal)
        $0.backgroundColor = .red
        return $0
    }(UIButton())
    
    let numButton2: UIButton = {
        $0.setTitle("2", for: .normal)
        $0.backgroundColor = .red
        return $0
    }(UIButton())
    
    let numButton3: UIButton = {
        $0.setTitle("3", for: .normal)
        $0.backgroundColor = .red
        return $0
    }(UIButton())
    
    let numButton4: UIButton = {
        $0.setTitle("4", for: .normal)
        $0.backgroundColor = .red
        return $0
    }(UIButton())
    
    let numButton5: UIButton = {
        $0.setTitle("5", for: .normal)
        $0.backgroundColor = .red
        return $0
    }(UIButton())
    let numButton6: UIButton = {
        $0.setTitle("6", for: .normal)
        $0.backgroundColor = .red
        return $0
    }(UIButton())
    let numButton7: UIButton = {
        $0.setTitle("7", for: .normal)
        $0.backgroundColor = .red
        return $0
    }(UIButton())
    let numButton8: UIButton = {
        $0.setTitle("8", for: .normal)
        $0.backgroundColor = .red
        return $0
    }(UIButton())
    let numButton9: UIButton = {
        $0.setTitle("9", for: .normal)
        $0.backgroundColor = .red
        return $0
    }(UIButton())
    
    let plusButton: UIButton = {
        $0.setTitle("+", for: .normal)
        $0.backgroundColor = .red
        return $0
    }(UIButton())
    
    let minusButton: UIButton = {
        $0.setTitle("-", for: .normal)
        $0.backgroundColor = .red
        return $0
    }(UIButton())
    
    let multiplyButton: UIButton = {
        $0.setTitle("x", for: .normal)
        $0.backgroundColor = .red
        return $0
    }(UIButton())
    
    let divideButton: UIButton = {
        $0.setTitle("/", for: .normal)
        $0.backgroundColor = .red
        return $0
    }(UIButton())
    
    let deleteLastButton: UIButton = {
        $0.setTitle("del", for: .normal)
        $0.backgroundColor = .red
        return $0
    }(UIButton())
    
    let clearAllButton: UIButton = {
        $0.setTitle("AC", for: .normal)
        $0.backgroundColor = .red
        return $0
    }(UIButton())
    
    let percentButton: UIButton = {
        $0.setTitle("%", for: .normal)
        $0.backgroundColor = .red
        return $0
    }(UIButton())

    let outputButton: UIButton = {
        $0.setTitle("=", for: .normal)
        $0.backgroundColor = .red
        return $0
    }(UIButton())
    
    let changeSignButton: UIButton = {
        $0.setTitle("+/-", for: .normal)
        $0.backgroundColor = .red
        return $0
    }(UIButton())
    
    let commaButton: UIButton = {
        $0.setTitle(",", for: .normal)
        $0.backgroundColor = .red
        return $0
    }(UIButton())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

        view.addSubview(verticalStack1)
        view.addSubview(inputAndOutputLabel)
        
        let bottomButtons: [UIButton] = [changeSignButton, numButton0, commaButton, outputButton]
        let stack123buttons: [UIButton] = [numButton1, numButton2, numButton3, plusButton]
        
        let stack456Buttons: [UIButton] = [numButton4, numButton5, numButton6, minusButton]
        
        let stack789Buttons: [UIButton] = [numButton7, numButton8, numButton9, multiplyButton]
        
        let topButtons: [UIButton] = [deleteLastButton, clearAllButton, percentButton, divideButton]
        
        let stack1 = createStack(from: stack123buttons)
        let stack2 = createStack(from: stack456Buttons)
        let stack3 = createStack(from: stack789Buttons)
        let stack0 = createStack(from: bottomButtons)
        let stack4 = createStack(from: topButtons)
        
        verticalStack1.addArrangedSubview(stack4)
        verticalStack1.addArrangedSubview(stack3)
        verticalStack1.addArrangedSubview(stack2)
        verticalStack1.addArrangedSubview(stack1)
        verticalStack1.addArrangedSubview(stack0)
        
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

    func setConstraints() {
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

