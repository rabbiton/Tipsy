//
//  ViewController.swift
//  Tipsy
//
//  Created by Yarema Zaiachuk on 09/09/2020.
//

import UIKit

class CalculatorViewController: UIViewController {
    
    var tip: Double = 0.0
    var amount: Double = 0.0
    var countOfPerson: Int = 2
    var finalResult: String = "0.0"

    @IBOutlet weak var billTextField: UITextField!
    @IBOutlet weak var zeroPctButton: UIButton!
    @IBOutlet weak var tenPctButton: UIButton!
    @IBOutlet weak var twentyPctButton: UIButton!
    @IBOutlet weak var splitNumberLabel: UILabel!
    
    @IBAction func tipChanged(_ sender: UIButton) {

//        zeroPctButton.isSelected = false
//        tenPctButton.isSelected = false
//        twentyPctButton.isSelected = false
//
//        sender.isSelected = true
//
//        let buttonTitle = sender.currentTitle!
//        let buttontitleMinusPercenSign = String(buttonTitle.dropLast())
//        let buttontitleAsANumber = Double(buttontitleMinusPercenSign)!
//        tip = buttontitleAsANumber / 100
       
        if sender.titleLabel?.text == "0%"{
            zeroPctButton.isSelected = true
            tenPctButton.isSelected = false
            twentyPctButton.isSelected = false
            tip = 0.0
        }
        if sender.titleLabel?.text == "10%"{
            zeroPctButton.isSelected = false
            tenPctButton.isSelected = true
            twentyPctButton.isSelected = false
            tip = 0.1
        }
        if sender.titleLabel?.text == "20%"{
            zeroPctButton.isSelected = false
            tenPctButton.isSelected = false
            twentyPctButton.isSelected = true
            tip = 0.2
        }
        billTextField.endEditing(true)
    }
    
    @IBAction func stepperValueChanged(_ sender: UIStepper) {
        splitNumberLabel.text = String(format: "%.0f", sender.value)
        countOfPerson = Int(sender.value)
    }
    
    @IBAction func calculatePressed(_ sender: UIButton) {
        
        let bill = billTextField.text!
        if bill != "" {
            amount = Double(bill)!
            let result = (amount * (1 + tip)) / Double(countOfPerson)
            if result - Double(Int(result)) == 0 {
                finalResult = String(format: "%.0f", result)
            } else {
                finalResult = String(format: "%.2f", result)
            }
        }
        self.performSegue(withIdentifier: "goToResult", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        //If the currently triggered segue is the "goToResults" segue.
        if segue.identifier == "goToResult" {
                   
        //Get hold of the instance of the destination VC and type cast it to a ResultViewController.
        let destinationVC = segue.destination as! ResultsViewController
                   
            //Set the destination ResultsViewController's properties.
            destinationVC.result = finalResult
            destinationVC.tip = Int(tip * 100)
            destinationVC.split = countOfPerson
        }
    }
    
}

