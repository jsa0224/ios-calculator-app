//
//  Formula.swift
//  Calculator
//
//  Created by 정선아 on 2022/09/23.
//

import Foundation

struct Formula {
    var operands = CalculatorItemQueue<Double>()
    var operators = CalculatorItemQueue<Operator>()
    
    enum FormulaError: Error {
        case emptyOperandsQueue
        case emptyOperatorsQueue
    }
    
    mutating func result() throws -> Double {
        guard var result: Double = operands.deQueue() else {
            throw FormulaError.emptyOperandsQueue
        }
        
        while !operands.isEmpty {
            print(operands, operators)
            guard let inputOperator = operators.deQueue() else {
                throw FormulaError.emptyOperatorsQueue
            }
            
            guard let inputOperands = operands.deQueue() else {
                throw FormulaError.emptyOperandsQueue
            }
            
            result = inputOperator.calculate(lhs: result, rhs: inputOperands) ?? 0
        }
        
        return result
    }
}