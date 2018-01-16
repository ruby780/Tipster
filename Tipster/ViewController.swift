//
//  ViewController.swift
//  Tipster
//
//  Created by Ruben A Gonzalez on 1/8/18.
//  Copyright © 2018 Ruben A Gonzalez. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var billField: UITextField!
    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var tipControl: UISegmentedControl!
    @IBOutlet weak var twoTotal: UILabel!
    @IBOutlet weak var threeTotal: UILabel!
    @IBOutlet weak var fourTotal: UILabel!
    @IBOutlet weak var amountView: UIView!
    @IBOutlet weak var dollarSign: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        billField.center.y = 230
        amountView.center.y += view.bounds.height
        tipControl.center.y += view.bounds.height
        dollarSign.center.y = 230
        dollarSign.alpha = 1
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("view will appear")
        // This is a good place to retrieve the default tip percentage from UserDefaults
        // and use it to update the tip amount
        
        let defaults = UserDefaults.standard
        tipControl.selectedSegmentIndex = defaults.integer(forKey: "defaultTip")
        calculateTip(tipControl)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // Automatically displays keypad
        billField.becomeFirstResponder()
        print("view did appear")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        print("view will disappear")
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("view did disappear")
    }

    @IBAction func OnTap(_ sender: AnyObject) {
        view.endEditing(true)
    }
    
    func showOtherObjects() {
        dollarSign.alpha = 0
        dollarSign.center.y = 120
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseInOut, animations: {
            self.billField.center.y = 120
            self.tipControl.center.y = 189
            self.amountView.center.y = 396
        }, completion: nil)
    }
    
    func hideOtherObjects() {
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseInOut, animations: {
            self.billField.center.y = 230
            self.tipControl.center.y += self.view.bounds.height
            self.amountView.center.y += self.view.bounds.height
            self.dollarSign.alpha = 1
            self.dollarSign.center.y = 230
        }, completion: nil)
    }
    
    @IBAction func calculateTip(_ sender: AnyObject) {
        showOtherObjects()
        
        let tipPercentages = [0.18, 0.2, 0.25]
        
        let bill = Double(billField.text!) ?? 0
        let tip = bill * tipPercentages[tipControl.selectedSegmentIndex]
        let total = bill + tip
        let total2 = total/2
        let total3 = total/3
        let total4 = total/4
        
        tipLabel.text = String(format: "$%.2f", tip)
        totalLabel.text = String(format: "$%.2f", total)
        twoTotal.text = String(format: "$%.2f", total2)
        threeTotal.text = String(format: "$%.2f", total3)
        fourTotal.text = String(format: "$%.2f", total4)
        
        if billField.text != "" {
            showOtherObjects()
        } else {
            hideOtherObjects()
        }
    }
    
}

