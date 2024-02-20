//
//  Formula.swift
//  Calculator
//
//  Created by Prism, Hamzzi on 2/12/24.
//

struct Formula {
    var operands: CalculatorItemQueue<Double>
    var operators: CalculatorItemQueue<Operator>
    
    mutating func result() throws -> Double {
        guard operands.count == operators.count + 1, 
              var result = operands.dequeue() else {
            throw CalculateError.invalidFormula
        }
        
        while !operators.isEmpty {
            guard let `operator` = operators.dequeue(),
                  let operand = operands.dequeue() else {
                throw CalculateError.invalidFormula
            }
            
            result = try `operator`.calculate(lhs: result, rhs: operand)
        }
        
        return result
    }
}

extension Formula: Equatable {
    static func ==(lhs: Formula, rhs: Formula) -> Bool {
        return (lhs.operands == rhs.operands) && (lhs.operators == rhs.operators)
    }
}
