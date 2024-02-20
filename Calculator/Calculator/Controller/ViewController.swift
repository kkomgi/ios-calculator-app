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
        
    }
    
    func convertToInputForm(operand: String) {
        
    }
    
    func convertToOutputForm(operand: String) {
        
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
