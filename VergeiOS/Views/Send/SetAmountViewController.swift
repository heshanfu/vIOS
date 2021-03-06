//
//  SetAmountViewController.swift
//  VergeiOS
//
//  Created by Swen van Zanten on 11-08-18.
//  Copyright © 2018 Verge Currency. All rights reserved.
//

import UIKit

class SetAmountViewController: UIViewController, KeyboardDelegate {

    var sendViewController: SendViewController?
    
    @IBOutlet weak var currencyLabel: UILabel!
    @IBOutlet weak var amountLabel: UILabel!
    @IBOutlet weak var amountKeyboard: XvgAmountKeyboard!
    
    var amount = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.isSwipable()
        
        self.amountKeyboard.delegate = self
        self.amount = Double(truncating: self.sendViewController!.amount)
        
        self.updateAmountLabel()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func didReceiveInput(_ sender: Keyboard, input: String, keyboardKey: KeyboardKey) {
        var xvg = amountLabel.text!
        
        if (keyboardKey.isKind(of: BackKey.self)) {
            if xvg.count > 1 {
                xvg.removeLast()
            } else {
                xvg = "0"
            }
        } else {
            if (input == "." && xvg.contains(Character("."))) {
                return
            }
            
            if (xvg == "0") {
                xvg = ""
            }
            
            xvg.append(input)
        }
        
        amountLabel.text = xvg
        amount = Double(xvg)!
    }

    func updateAmountLabel() {
        amountLabel.text = (amount > 0) ? String(describing: amount) : "0"
    }
    
    @IBAction func setAmount(_ sender: Any) {
        sendViewController?.amount = NSNumber(value: amount)
        sendViewController?.updateAmountLabel()
        
        self.closeViewController(self)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    @IBAction func closeViewController(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }

}
