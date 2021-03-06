//
//  FinishSetupViewController.swift
//  VergeiOS
//
//  Created by Swen van Zanten on 29-07-18.
//  Copyright © 2018 Verge Currency. All rights reserved.
//

import UIKit

class FinishSetupViewController: AbstractPaperkeyViewController {

    @IBOutlet weak var checklistImage: UIImageView!
    @IBOutlet weak var checklistDescription: UILabel!
    @IBOutlet weak var openWalletButton: RoundedButton!
    
    weak var interval: Timer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.hidesBackButton = true
        self.openWalletButton.isHidden = true
        self.openWalletButton.alpha = 0
        self.openWalletButton.center.y += 30
        
        var selectedImage = 0
        var images = [
            "ChecklistTwoItem",
            "ChecklistThreeItem",
            "CheckmarkCircle"
        ]
        
        DispatchQueue.main.async {
           self.interval = setInterval(1) {
                self.checklistImage.image = UIImage(named: images[selectedImage])
                selectedImage += 1
            
                if selectedImage == images.count {
                    self.interval?.invalidate()
                    
                    self.checklistDescription.text = "Your wallet is ready! Congratulations!"
                    self.showWalletButton()
                }
            }
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        self.interval?.invalidate()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func showWalletButton() {
        UIView.animate(withDuration: 0.3) {
            self.openWalletButton.isHidden = false
            self.openWalletButton.alpha = 1
            self.openWalletButton.center.y -= 30
        }
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        WalletManager.default.setup = true
    }

}
