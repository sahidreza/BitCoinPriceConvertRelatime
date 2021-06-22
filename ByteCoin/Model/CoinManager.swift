//
//  CoinManager.swift
//  ByteCoin
//
//  Created by Sahid Reza on 22/06/21.
//  Copyright © 2021 The App Brewery. All rights reserved.
//

import Foundation

protocol CoinMangerDelegate {

   func didUpdateConData(coinPrice:Double,currency:String)
   func erorValue(error:Error)
    
}


struct CoinManager {
    
    var delegate:CoinMangerDelegate?
    
    let baseURL = "https://rest.coinapi.io/v1/exchangerate/BTC"
    let apiKey = "Use YouRapiKeyPlEase"
    
    let currencyArray = ["AUD", "BRL","CAD","CNY","EUR","GBP","HKD","IDR","ILS","INR","JPY","MXN","NOK","NZD","PLN","RON","RUB","SEK","SGD","USD","ZAR"]
    
    func getCoinPrice(for currency: String) {
        
        let url = "\(baseURL)/\(currency)?apikey=\(apiKey)"
        perfromRequst(urlString: url, currency: currency)
       }
    
    func perfromRequst(urlString:String,currency:String){
        
        if let url = URL(string: urlString){
            let sesion = URLSession(configuration: .default)
            let task = sesion.dataTask(with: url) { data, response, error in
                
                if error != nil {
                    
                    delegate?.erorValue(error: error!)
                    return
                    
                }
                
                if let safeData = data {
                    
                    if let coinData =  pharseJson(for: safeData){
                        
                        delegate?.didUpdateConData(coinPrice: coinData, currency: currency)
                    }
                    
                }
                
            }
            
            task.resume()
            
        }
        
    }
    
    func pharseJson(for coinData:Data) -> Double?{
        
        let decoder = JSONDecoder()
        do{
            
            let decoderData = try decoder.decode(CoinData.self, from: coinData)
            let coinPrce = decoderData.rate
            return coinPrce
            
        } catch{
            delegate?.erorValue(error: error)
            return nil
        }
        
    }

    
}
