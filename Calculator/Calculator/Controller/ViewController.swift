//
//  Calculator - ViewController.swift
//  Created by yagom. 
//  Copyright © yagom. All rights reserved.
// 

import UIKit

enum StringForm {
    case input
    case output
}

fileprivate extension String {
    func toFormattedString(style: NumberFormatter.Style) -> String {
        let numberFormatter = NumberFormatter()
        
        numberFormatter.usesSignificantDigits = true
        numberFormatter.maximumSignificantDigits = 20
        numberFormatter.numberStyle = style
        
        guard let formattedString = numberFormatter.string(for: Double(self)) else {
            return self
        }
        
        return formattedString
    }
}

class ViewController: UIViewController {
    var expression = ""
    var `operator`: Operator?
    var operand = "0"
    var isOperatorActivated = false
    var errorHasOccured = false
    
    @IBOutlet var operatorLabel: UILabel!
    @IBOutlet var operandLabel: UILabel!
    @IBOutlet var logsStackView: UIStackView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func updateExpression() {
        
    }
    
    func updateOperatorLabel() {
        if let `operator` = `operator` {
            operatorLabel.text = String(`operator`.rawValue)
        } else {
            operatorLabel.text = ""
        }
    }
    
    func updateOperandLabel(form: StringForm) {
        switch form {
        case .input:
            operandLabel.text = convertToInputForm(operand: operand)
        case .output:
            operandLabel.text = convertToOutputForm(operand: operand)
        }
    }
    
    func convertToInputForm(operand: String) -> String {
        if let firstIndexOfDot = operand.firstIndex(of: ".") {
            let integer = String(operand[..<firstIndexOfDot])
            let fraction = String(operand[operand.index(firstIndexOfDot, offsetBy: 1)...])
            
            let formattedInteger = integer.toFormattedString(style: .decimal)
            
            if fraction == "" {
                return formattedInteger + "."
            } else {
                return formattedInteger + "." + fraction
            }
        } else {
            let formattedOperand = operand.toFormattedString(style: .decimal)
            
            return formattedOperand
        }
    }
    
    func convertToOutputForm(operand: String) -> String {
        let formattedOperand = operand.toFormattedString(style: .decimal)
        
        return formattedOperand
    }

    @IBAction func acButtonTouchedUP(_ sender: UIButton) {
        
    }
    
    @IBAction func ceButtonTouchedUp(_ sender: UIButton) {
        
    }
    
    @IBAction func signToggleButtonTouchedUp(_ sender: UIButton) {
        
    }
    
    @IBAction func operatorButtonTouchedUp(_ sender: UIButton) {
        
    }
    
    @IBAction func calculateButtonTouchedUp(_ sender: UIButton) {
        
    }
    
    @IBAction func dotButtonTouchedUp(_ sender: UIButton) {
        
    }
    
    @IBAction func numberButtonTouchedUp(_ sender: UIButton) {
        
    }
}
