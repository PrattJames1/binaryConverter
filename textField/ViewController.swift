//
//  ViewController.swift
//  textField
//
//  Created by James Pratt on 2/16/19.
//  Copyright © 2019 FlukeProductions.io. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var userInput: UITextField!
    
    var binaryOrDecimal = 0
    // 0 means the user wants to convert from Decimal to Binary.
    // 1 means the user wants to convert from Binary to Decimal.
    
    @IBAction func toggle(_ sender: Any) {
        if (sender as AnyObject).selectedSegmentIndex == 0 {
            binaryOrDecimal = 0
        }
        else {
            binaryOrDecimal = 1
        }
    }
    
    
    @IBAction func enterTapped(_ sender: Any) {
    
        var number = Int(userInput.text!) ?? 0
        var array: [Int] = []
        
        if binaryOrDecimal == 0 {
            while (number != 0) {
                if (number % 2 == 1) {
                    array.insert(1, at: 0)
                }
                else {
                    array.insert(0, at: 0)
                }
                number = number / 2
            }
            
            var binaryConversion = ""
            for digit in array {
                print(digit, terminator: "")
                binaryConversion += String(digit)
            }
            
            textView.text = "[\(userInput.text!)] in binary is: [" + binaryConversion + "]"
        }
            
        else {
            
            // Take the user input string and convert it into an array of characters.
            let input: String = userInput.text!
            let characterArray: [Character] = Array(input)
            var totalSum: Decimal = 0
            
            // Take the array of characters and convert it into an array of integers.
            for character in characterArray {
                let stringBit = String(character)
                let bitValue = Int(stringBit)
                array.insert(bitValue!, at: 0)
            }
            
            // for each digit in array, multiply by 2 to the power of its current position in the array. Add that to totalSum.
            // The power function converts the integer to a decimal. So you need to convert the totalSum and value to a decimal so the calculations will be compatible.
            for (index, value) in array.enumerated() {
                let valueFloat = Decimal(value)
                totalSum += valueFloat * pow(2, index)
            }
            
            textView.text = "[\(userInput.text!)] in decimal is: [" + "\(totalSum)" + "]"
        }
    }
    
    
    @IBOutlet weak var textView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        userInput.delegate = self
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        userInput.resignFirstResponder()
    }
}

extension ViewController : UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        userInput.resignFirstResponder()
        return true
    }
}
