//
//  ViewController.swift
//  calculatorKeyboard
//
//  Created by Kenny Batista on 1/9/16.
//  Copyright © 2016 Kenny Batista. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var textField: UITextField!
    
    
    
    @IBAction func clearTextField(){
        textField.text = " "
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        textField.becomeFirstResponder()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

