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
    
    let numButton0: UIButton = {
        $0.setTitle("0", for: .normal)
//        $0.addTarget(ViewController.self, action: #selector(printButtonTapped), for: .touchUpInside)
        return $0
    }(UIButton())
    
    let numButton1: UIButton = {
        $0.setTitle("1", for: .normal)
  //      $0.addTarget(ViewController.self, action: #selector(printButtonTapped), for: .touchUpInside)
        return $0
    }(UIButton())
    
    let numButton2: UIButton = {
        $0.setTitle("2", for: .normal)
    //    $0.addTarget(ViewController.self, action: #selector(printButtonTapped), for: .touchUpInside)
        return $0
        
    }(UIButton())
    
    let numButton3: UIButton = {
        $0.setTitle("3", for: .normal)
      //  $0.addTarget(ViewController.self, action: #selector(printButtonTapped), for: .touchUpInside)
        return $0
    }(UIButton())
    
    let numButton4: UIButton = {
        $0.setTitle("4", for: .normal)
        //$0.addTarget(ViewController.self, action: #selector(printButtonTapped), for: .touchUpInside)
        return $0
    }(UIButton())
    
    let numButton5: UIButton = {
        $0.setTitle("5", for: .normal)
        //$0.addTarget(ViewController.self, action: #selector(printButtonTapped), for: .touchUpInside)
        return $0
    }(UIButton())
    let numButton6: UIButton = {
        $0.setTitle("6", for: .normal)
 //       $0.addTarget(ViewController.self, action: #selector(printButtonTapped), for: .touchUpInside)
        return $0
    }(UIButton())
    let numButton7: UIButton = {
        $0.setTitle("7", for: .normal)
//        $0.addTarget(ViewController.self, action: #selector(printButtonTapped), for: .touchUpInside)
        return $0
    }(UIButton())
    let numButton8: UIButton = {
        $0.setTitle("8", for: .normal)
//        $0.addTarget(ViewController.self, action: #selector(printButtonTapped), for: .touchUpInside)
        return $0
    }(UIButton())
    let numButton9: UIButton = {
        $0.setTitle("9", for: .normal)
//        $0.addTarget(ViewController.self, action: #selector(printButtonTapped), for: .touchUpInside)
        return $0
    }(UIButton())
    
    let plusButton: UIButton = {
        $0.setTitle("+", for: .normal)
//        $0.addTarget(ViewController.self, action: #selector(printButtonTapped), for: .touchUpInside)
        return $0
    }(UIButton())
    
    let minusButton: UIButton = {
        $0.setTitle("-", for: .normal)
//        $0.addTarget(ViewController.self, action: #selector(printButtonTapped), for: .touchUpInside)
        return $0
    }(UIButton())
    
    let multiplyButton: UIButton = {
        $0.setTitle("*", for: .normal)
        return $0
    }(UIButton())
    
    let divideButton: UIButton = {
        $0.setTitle("/", for: .normal)
//        $0.addTarget(ViewController.self, action: #selector(printButtonTapped), for: .touchUpInside)
        return $0
    }(UIButton())
    
    let deleteLastButton: UIButton = {
        $0.setTitle("del", for: .normal)
        return $0
    }(UIButton())
    
    let clearAllButton: UIButton = {
        $0.setTitle("AC", for: .normal)
        return $0
    }(UIButton())
    
    let percentButton: UIButton = {
        $0.setTitle("%", for: .normal)
        return $0
    }(UIButton())

    let outputButton: UIButton = {
        $0.setTitle("=", for: .normal)
        return $0
    }(UIButton())
    
    let changeSignButton: UIButton = {
        $0.setTitle("+/-", for: .normal)
        return $0
    }(UIButton())
    
    let commaButton: UIButton = {
        $0.setTitle(",", for: .normal)
        return $0
    }(UIButton())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

        view.addSubview(verticalStack1)
        view.addSubview(inputAndOutputLabel)
        
        let bottomButtons: [UIButton] = [changeSignButton, numButton0, commaButton, outputButton]
        let stack123Buttons: [UIButton] = [numButton1, numButton2, numButton3, plusButton]
        
        let stack456Buttons: [UIButton] = [numButton4, numButton5, numButton6, minusButton]
        
        let stack789Buttons: [UIButton] = [numButton7, numButton8, numButton9, multiplyButton]
        
        let topButtons: [UIButton] = [deleteLastButton, clearAllButton, percentButton, divideButton]
        
        let signButtons: [UIButton] = [percentButton, divideButton, multiplyButton, minusButton, plusButton, commaButton, changeSignButton]
        
        let numsButtons: [UIButton] = [numButton0, numButton1, numButton2, numButton3, numButton4, numButton5, numButton6, numButton7, numButton8, numButton9]
        
        let allButtons = stack123Buttons + stack456Buttons + stack789Buttons + topButtons + bottomButtons
        
        let stack1 = createStack(from: stack123Buttons)
        let stack2 = createStack(from: stack456Buttons)
        let stack3 = createStack(from: stack789Buttons)
        let stack0 = createStack(from: bottomButtons)
        let stack4 = createStack(from: topButtons)
        
        verticalStack1.addArrangedSubview(stack4)
        verticalStack1.addArrangedSubview(stack3)
        verticalStack1.addArrangedSubview(stack2)
        verticalStack1.addArrangedSubview(stack1)
        verticalStack1.addArrangedSubview(stack0)

        
        for button in allButtons {
            if numsButtons.contains(button) {
                button.backgroundColor = .lightGray
            }
            else {
                button.backgroundColor = .red
            }
            button.addTarget(self, action: #selector(printButtonTapped), for: .touchUpInside)
            button.layer.cornerRadius = 8

        }
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
    
    func mathOperation(_ str: String) -> String {
        var ans = ""
        
        return ans
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

