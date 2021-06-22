//
//  ViewController.swift
//  ByteCoin
//
//  Created by Sahid Reza on 22/06/21.
//  Copyright © 2021 The App Brewery. All rights reserved.
//


import UIKit

class CoinViewController: UIViewController{
    
    @IBOutlet weak var bitCoinLabel: UILabel!
    @IBOutlet weak var bitCoinCurrencyLabel: UILabel!
    @IBOutlet weak var currencyPicker: UIPickerView!
    var coinManager = CoinManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        currencyPicker.dataSource = self
        currencyPicker.delegate = self
        coinManager.delegate = self
    }


}

extension CoinViewController:UIPickerViewDataSource,UIPickerViewDelegate{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        return coinManager.currencyArray.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        return coinManager.currencyArray[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        let selectedCurrency = coinManager.currencyArray[row]
        coinManager.getCoinPrice(for: selectedCurrency)
        
    }
    
    
}

extension CoinViewController:CoinMangerDelegate{
    func didUpdateConData(coinPrice: Double, currency: String) {
        DispatchQueue.main.async {
            self.bitCoinLabel.text = String(Int(coinPrice))
            self.bitCoinCurrencyLabel.text = currency
        }
    }
    
    func erorValue(error: Error) {
        
        print("error")
    }
    
    
}

