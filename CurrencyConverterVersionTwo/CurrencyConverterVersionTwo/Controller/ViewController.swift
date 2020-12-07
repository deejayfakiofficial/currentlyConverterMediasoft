//
//  ViewController.swift
//  CurrencyConverterVersionTwo
//
//  Created by Admin on 05.12.2020.
//

import UIKit

class ViewController: UIViewController {
    
    //MARK: - Variable
    
//    var currencyName: [String] = []
//    var currencyValue: [Double] = []
    var activeValue = 0.0
    var activeName = "RUB"
        
        
    @IBOutlet weak var secondCurrencyLabel: UILabel!
    @IBOutlet weak var firstTF: UITextField!
    @IBOutlet weak var secondTF: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        secondTF.delegate = self
        firstTF.delegate = self
        notificationKeyboard ()
        fetchJSON()
        firstTF.addTarget(self, action: #selector(updateView(input:)), for: .editingDidEnd)
    }
    
    //MARK: - Method
    
    @IBAction func selectCurrencyName(_ sender: UIButton!) {
    }
    
    @objc func updateView (input: Double) {
        guard let newText = firstTF.text,
              let theNewText = Double(newText) else {
            self.alert(title: "Ошибка", message: "Введите число", style: .alert)
            secondTF.text = String(activeValue)
            return
        }
        if firstTF.text != "" {
            let total = theNewText * activeValue
            secondTF.text = String(format: "%.2f", total)
            secondCurrencyLabel.text = activeName.description
            HistoryDataSource.history.append("\(firstTF.text!) USD = \(secondTF.text!) \(secondCurrencyLabel.text!)")
        }
    }
    
    func fetchJSON () {
        guard let url = URL(string: "https://open.exchangerate-api.com/v6/latest") else { return }
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if error != nil {
                print (error?.localizedDescription as Any)
                return
            }
            guard let data = data else { return }
            do {
                let results = try JSONDecoder().decode(ExchangeRates.self, from: data)
//                self.currencyName.append(contentsOf: results.rates.keys)
//                self.currencyValue.append(contentsOf: results.rates.values)
                self.activeValue = results.rates["RUB"]!
                ChangeCountry.changeCountry.append(contentsOf: results.rates.keys)
                ChangeCountry.countryValue.append(contentsOf: results.rates.values)
                print(results)
            }
            catch {
                print(error.localizedDescription)
            }
        }.resume()
    }
    
    func alert(title: String, message: String, style: UIAlertController.Style) {
        let alertcontroller = UIAlertController(title: title, message: message, preferredStyle: style)
        let action = UIAlertAction(title: "OK", style: .cancel) { (action) in
            let text = alertcontroller.textFields?.first
            self.firstTF.text! = (text?.text!)!
        }
        alertcontroller.addTextField { (textField) in
            textField.keyboardType = .numberPad
        }
        alertcontroller.addAction(action)
        self.present(alertcontroller, animated: true, completion: nil)
    }
    
    func notificationKeyboard () {
        NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillShowNotification, object: nil, queue: nil) { (nc) in
            self.view.frame.origin.y = -50
        }
        NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillHideNotification, object: nil, queue: nil) { (nc) in
            self.view.frame.origin.y = 0.0
        }
    }
}

//MARK: - Extension

extension ViewController: UITextFieldDelegate {
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        self.firstTF.resignFirstResponder()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.firstTF.resignFirstResponder()
        self.secondTF.resignFirstResponder()
        return true
    }
}

