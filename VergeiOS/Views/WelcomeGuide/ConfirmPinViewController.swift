//
//  ConfirmPinViewController.swift
//  VergeiOS
//
//  Created by Swen van Zanten on 25-07-18.
//  Copyright © 2018 Verge Currency. All rights reserved.
//

import UIKit

class ConfirmPinViewController: UIViewController, KeyboardDelegate {
    
    @IBOutlet weak var pinTextField: PinTextField!
    @IBOutlet weak var pinKeyboard: PinKeyboard!
    @IBOutlet weak var pinConfirmedView: PanelView!
    @IBOutlet weak var pinFailedView: PanelView!
    
    var previousPin: String = ""
    var pin: String = ""
    
    override func viewDidLoad() {
        self.pinKeyboard.delegate = self
        self.pinConfirmedView.isHidden = true
        self.pinFailedView.isHidden = true
    }
    
    func didReceiveInput(_ sender: Keyboard, input: String, keyboardKey: KeyboardKey) {
        if (keyboardKey.isKind(of: BackKey.self)) {
            self.pinTextField.removeCharacter()
            
            if (pin.count > 0) {
                pin = String(pin[..<pin.index(pin.endIndex, offsetBy: -1)])
            }
        } else {
            self.pinTextField.addCharacter()
            
            if (pin.count < self.pinTextField.pinCharacterCount) {
                pin = "\(pin)\(input)"
            }
            
            // When all pins are set.
            if (pin.count == self.pinTextField.pinCharacterCount) {
                self.handlePinCreation()
            }
        }
    }
    
    func handlePinCreation() {
        if (self.pin == self.previousPin) {
            self.pinConfirmedView.alpha = 0.0
            self.pinConfirmedView.center.y -= 60.0
            UIView.animate(withDuration: 0.3, delay: 0.3, options: .curveEaseInOut, animations: {
                self.pinKeyboard.alpha = 0.0
                
                self.pinConfirmedView.isHidden = false
                self.pinConfirmedView.alpha = 1.0
                self.pinConfirmedView.center.y += 60.0
            }, completion: nil)
        } else {
            self.pinFailedView.alpha = 0.0
            self.pinFailedView.center.y -= 60
            UIView.animate(withDuration: 0.3, delay: 0.3, options: .curveEaseInOut, animations: {
                self.pinKeyboard.alpha = 0.0
                
                self.pinFailedView.isHidden = false
                self.pinFailedView.alpha = 1.0
                self.pinFailedView.center.y += 60.0
                
            }, completion: nil)
            // self.performSegue(withIdentifier: "backToEnterKey", sender: self)
        }
    }
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Set the wallet pin.
        if segue.identifier == "confirmPin" {
            WalletManager.default.pin = self.pin
        }
    }

}
