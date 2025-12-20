//
//  CalculatorViewController.swift
//  MyCalculator
//
//  Created by Артём on 18.12.2025.
//

import UIKit

class ViewController: UIViewController {

    private lazy var displayLabel: UILabel = {
        $0.textAlignment = .right
        $0.text = "0"
        $0.font = .systemFont(ofSize: 45)
        return $0
    }(UILabel())
    
    private lazy var answerLabel: UILabel = {
        $0.text = ""
        $0.font = .systemFont(ofSize: 20)
        $0.textColor = .lightGray
        $0.textAlignment = .right
        return $0
    }(UILabel())
    
    private lazy var mainStackView: UIStackView = {
        $0.axis = .vertical
        $0.distribution = .fillEqually
        $0.spacing = 10
        return $0
    }(UIStackView())
    
    private lazy var answerScrollView = {
        createScrollView()
    }()
    
    private lazy var displayScrollView = {
        createScrollView()
    }()

    private var calculatorLogic = CalculatorLogic()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        setupButtons()
        setupConstraints()
    }
    //MARK: - Setup View
    
    private func setupUI() {
        view.addSubview(answerScrollView)
        view.addSubview(displayScrollView)
        view.addSubview(mainStackView)
        
        answerScrollView.addSubview(answerLabel)
        displayScrollView.addSubview(displayLabel)
        
        answerLabel.translatesAutoresizingMaskIntoConstraints = false
        displayLabel.translatesAutoresizingMaskIntoConstraints = false
        answerScrollView.translatesAutoresizingMaskIntoConstraints = false
        displayScrollView.translatesAutoresizingMaskIntoConstraints = false
        mainStackView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func setupButtons() {
        let buttonsLayout = CalculatorButtonType.buttonLayout
        
        for row in buttonsLayout.reversed() {
            let buttonStack = createButtonStack(for: row)
            mainStackView.addArrangedSubview(buttonStack)
        }
    }
    
    private func createScrollView() -> UIScrollView {
        let myScrollView = UIScrollView()
            myScrollView.showsHorizontalScrollIndicator = false
            myScrollView.alwaysBounceHorizontal = true
            myScrollView.semanticContentAttribute = .forceRightToLeft
            return myScrollView
    }
    
    private func createButton(of buttonType: CalculatorButtonType) -> UIButton {
        let button = UIButton()
        button.backgroundColor = buttonType.backgroundColor
        button.layer.opacity = 0.8
        button.layer.cornerRadius = 8
        button.setTitle(buttonType.title, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 25, weight: .medium)
        button.titleLabel?.textColor = .white
        button.tag = buttonType.tag
        button.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
        
        button.startAnimatingPressAction()
        
        return button
    }
    
    private func createButtonStack(for buttonTypes: [CalculatorButtonType]) -> UIStackView {
        let horizontalStackView = UIStackView()
        
        horizontalStackView.axis = .horizontal
        horizontalStackView.distribution = .fillEqually
        horizontalStackView.spacing = 10
        
        buttonTypes.forEach { buttonType in
            let button = createButton(of: buttonType)
            horizontalStackView.addArrangedSubview(button)
        }
        
        return horizontalStackView
    }
    //MARK: - Buttons Actions
    @objc private func buttonPressed(_ sender: UIButton) {
        if displayLabel.text == "0" {
            displayLabel.text = ""
        }
        guard let buttonType = getButtonType(for: sender.tag) else { return }
        
        scrollToRightEnd()
        
        handleButtonAction(for: buttonType)
    }
    
    private func handleButtonAction(for buttonType: CalculatorButtonType) {
        switch buttonType {
        case .number(let num):
            appendToDisplay(num)
        case .operation(let operation):
            appendOperation(operation)
        case .percent:
            appendPercent()
        case .comma:
            appendComma()
        case .delete:
            deleteLast()
        case .clearAll:
            clearAll()
        case .plusMinus:
            togglePlusMinus()
        case .equals:
            calculateResult()
        }
    }
    
    private func getButtonType(for tag: Int) -> CalculatorButtonType? {
        for row in CalculatorButtonType.buttonLayout {
            for buttomType in row where buttomType.tag == tag {
                return buttomType
            }
        }
        return nil
    }
    
    private func scrollToRightEnd() {
        let contentWidth = displayScrollView.contentSize.width
        let scrollViewWidth = displayScrollView.bounds.width
        
        if contentWidth > scrollViewWidth {
            let offsetX = contentWidth - scrollViewWidth
            displayScrollView.setContentOffset(CGPoint(x: offsetX + 5, y: 0), animated: true)
        } else {
            displayScrollView.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
        }
    }
    
    private func scrollToLeftEnd() {
        displayScrollView.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
    }
    
    //MARK: - Calculator Opeartion
    private func appendToDisplay(_ char: String) {
        displayLabel.text?.append(char)
    }
    
    private func appendOperation(_ operation: String) {
        guard let displayText = displayLabel.text, let lastChar = displayText.last else { return }
        
        if calculatorLogic.canAddOperation(lastChar) {
            appendToDisplay(operation)
        }
    }
    
    private func appendPercent() {
        appendToDisplay("%")
    }
    
    private func appendComma() {
        if !(displayLabel.text?.contains(",") ?? false) {
            appendToDisplay(",")
        }
    }
    
    private func deleteLast() {
        answerLabel.text = ""
        
        guard var displayText = displayLabel.text, !displayText.isEmpty else {
            displayLabel.text = "0"
            return
        }
        
        displayText.removeLast()
        
        displayLabel.text = displayText.isEmpty ? "0" : displayText
    }
    
    private func clearAll() {
        answerLabel.text = ""
        displayLabel.text = "0"
    }
    
    private func togglePlusMinus() {
        guard let currentExpression = displayLabel.text else { return }
        displayLabel.text = calculatorLogic.changeSign(currentExpression)
    }
    
    private func calculateResult() {
        answerLabel.text = displayLabel.text
        
        guard let expression = displayLabel.text,
              let result = calculatorLogic.calculateExpression(expression) else {
            return
        }
        
        let formattedResult = calculatorLogic.formatResult(result)
        
        scrollToLeftEnd()
        
        displayLabel.text = formattedResult
    }
    
    //MARK: -Setup Constraints
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            
            answerScrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            answerScrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            answerScrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 130),
            answerScrollView.heightAnchor.constraint(equalToConstant: 50),
            
            answerLabel.leadingAnchor.constraint(equalTo: answerScrollView.leadingAnchor, constant: 20),
            answerLabel.trailingAnchor.constraint(equalTo: answerScrollView.trailingAnchor, constant: -20),
            answerLabel.topAnchor.constraint(equalTo: answerScrollView.topAnchor),
            answerLabel.bottomAnchor.constraint(equalTo: answerScrollView.bottomAnchor),
            answerLabel.heightAnchor.constraint(equalTo: answerScrollView.heightAnchor),
            
            displayScrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            displayScrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            displayScrollView.topAnchor.constraint(equalTo: answerScrollView.bottomAnchor),
            displayScrollView.heightAnchor.constraint(equalToConstant: 50),
            
            displayLabel.leadingAnchor.constraint(equalTo: displayScrollView.leadingAnchor, constant: 20),
            displayLabel.trailingAnchor.constraint(equalTo: displayScrollView.trailingAnchor, constant: -20),
            displayLabel.topAnchor.constraint(equalTo: displayScrollView.topAnchor),
            displayLabel.bottomAnchor.constraint(equalTo: displayScrollView.bottomAnchor),
            displayLabel.heightAnchor.constraint(equalTo: displayScrollView.heightAnchor),
            
            mainStackView.topAnchor.constraint(equalTo: displayLabel.bottomAnchor, constant: 20),
            mainStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            mainStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            mainStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 20)
        ])
    }
    
}
