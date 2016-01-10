//
//  KeyboardViewController.swift
//  Calculator
//
//  Created by Kenny Batista on 1/9/16.
//  Copyright © 2016 Kenny Batista. All rights reserved.
//

import UIKit

class KeyboardViewController: UIInputViewController {
    
    var clearTheDisplayBeforeInserting = true
    var keyboardView : UIView!
    
    @IBOutlet var nextKeyboard : UIButton!
    @IBOutlet var display : UILabel!
    
    
    enum Operation {
        case Addition
        case Multiplication
        case Subtraction
        case Division
        case None
    }
    
    var internalMemory = 0.0
    var nextOperation = Operation.None
    var shouldCompute = false
    
    
  

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadInterface()
        clearDisplay()
        
    }
    
    
    @IBAction func didTapOperation(operation : UIButton){
        if shouldCompute {
            computeLastOperation()
        }
        
        if let op = operation.titleLabel?.text {
            switch op {
                case "+":
                    nextOperation = Operation.Addition
                case "-":
                    nextOperation = Operation.Subtraction
                case "X":
                    nextOperation = Operation.Multiplication
                case "%":
                    nextOperation = Operation.Division
                default:
                    nextOperation = Operation.None
            }
        }
    }
    
    
    
    
    @IBAction func computeLastOperation() {
        // remember not to compute if another operation is pressed without inputing another number first
        shouldCompute = false
        
        if let input = display?.text {
            let inputAsDouble = (input as NSString).doubleValue
            var result = 0.0
            
            // apply the operation
            switch nextOperation {
            case .Addition:
                result = internalMemory + inputAsDouble
            case .Subtraction:
                result = internalMemory - inputAsDouble
            case .Multiplication:
                result = internalMemory * inputAsDouble
            case .Division:
                result = internalMemory / inputAsDouble
            default:
                result = 0.0
            }
            
//            nextOperation = Operation.None
            
            var output = "\(result)"
            
            // if the result is an integer don't show the decimal point
            if output.hasSuffix(".0") {
                output = "\(Int(result))"
            }
            
//            // truncatingg to last five digits
//            var components = output.componentsSeparatedByString(".")
//            if components.count >= 2 {
//                let beforePoint = components[0]
//                var afterPoint = components[1]
//                if afterPoint.lengthOfBytesUsingEncoding(NSUTF8StringEncoding) > 5 {
//                    //let index: String.Index = advance(afterPoint.startIndex, 5)
//                    let startIndex = afterPoint.endIndex.advancedBy(5)
//                    afterPoint = afterPoint.substringToIndex(startIndex)
//                }
//                output = beforePoint + "." + afterPoint
//            }
            
            
            // update the display
            display.text = output
            
            // save the result
            internalMemory = result
            
            // remember to clear the display before inserting a new number
            clearTheDisplayBeforeInserting = true
        }
    }
    


    @IBAction func clearDisplay(){
        display.text = "0"
        internalMemory = 0
        nextOperation = Operation.Addition
        clearTheDisplayBeforeInserting = true
    }


    
    @IBAction func didTapNumber(number: UIButton!){
        if clearTheDisplayBeforeInserting {
            display.text = " "
            clearTheDisplayBeforeInserting = false
        }
        
        if let numberAsString = number.titleLabel?.text {
            let numberAsNSString = numberAsString as NSString
            if let oldDisplay = display?.text! {
                display.text = "\(oldDisplay)\(numberAsNSString.intValue)"
            } else {
                display.text = "\(numberAsNSString.intValue)"
            }
        }
    }
    
    
    @IBAction func didTapDot(){
        if let input = display?.text {
            var hasDot = false
            for ch in input.unicodeScalars {
                if ch == "." {
                    hasDot = true
                    break
                }
            }
            if hasDot == false {
                display.text = "\(input)."
            }
        }
    }
    
    
    @IBAction func didTapInsert() {
        let proxy = textDocumentProxy as UITextDocumentProxy
        
        if let input = display?.text as String? {
            proxy.insertText(input)
        }
    }
    
    func loadInterface(){
        //Load the NIB File -- Here we store the nib file in the calbulatorNib constant
        let calculatorNIB = UINib(nibName: "Calculator", bundle: nil)
        
        //Instantiate the view -
        keyboardView = calculatorNIB.instantiateWithOwner(self, options: nil)[0] as! UIView
        
        //Add to main view -- without this we won't be able to see the view.
        view.addSubview(keyboardView)
        
        //Copying the background color.
        view.backgroundColor = keyboardView.backgroundColor
        //keyboardView.backgroundColor = UIColor.redColor() -- makes the background color red.
        
        //Next Keyboard button
        nextKeyboard.addTarget(self, action: "advanceToNextInputMode()", forControlEvents: .TouchUpInside)
    }


}
