//
//  ViewController.swift
//  Calculator
//
//  Created by Ruben on 21/02/15.
//  Copyright (c) 2015 Ruben. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var display: UILabel!
    
    var firstDigitTyped = true
    
    @IBAction func appendDigit(sender: UIButton) {
        let digit = sender.currentTitle!
        if (firstDigitTyped){
            display.text = digit
            firstDigitTyped = false
        }
        else{
            display.text = display.text! + digit
        }
        println(digit)
    }
    
    @IBAction func operate(sender: UIButton) {
        let operation = sender.currentTitle!
        if !firstDigitTyped{
            enter()
        }
        switch operation{
        case "✖️": performOperation{ $0 * $1 }
        case "➗": performOperation{ $1 / $0 }
        case "➕": performOperation{ $0 + $1 }
        case "➖": performOperation{ $1 - $0 }
        case "√": performOperation{ sqrt($0) }
        default: break
        }
    }
    
    func performOperation(operation: (Double, Double) -> Double){
        if operandStack.count >= 2{
            displayValue = operation(operandStack.removeLast(), operandStack.removeLast())
            enter()
        }
    }
    
    func performOperation(operation: Double -> Double){
        if operandStack.count >= 1{
            displayValue = operation(operandStack.removeLast())
            enter()
        }
    }
    var operandStack = Array<Double>()
    
    @IBAction func enter() {
        firstDigitTyped = true
        operandStack.append(displayValue)
        println("operandStack = \(operandStack)")
    }
    
    var displayValue: Double {
        get{
            return NSNumberFormatter().numberFromString(display.text!)!.doubleValue
        }
        set{
            display.text = "\(newValue)"
            firstDigitTyped = false
        }
    }
    
    
}

