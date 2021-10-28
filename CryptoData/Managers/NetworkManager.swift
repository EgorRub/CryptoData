//
//  NetworkManager.swift
//  CryptoData
//
//  Created by Егор on 11.10.2021.
//

import Foundation


class NetworkManager {
    
    static let shared = NetworkManager()
    
    func fetchData(_ completion: @escaping (Crypto, [Data]) -> Void) {
    
        let jsonURL = "https://api.coinlore.net/api/tickers/"
        guard let url = URL(string: jsonURL) else { return }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                print(error)
            }
            guard let data = data else { return }
            
            do {
                let crypro = try JSONDecoder().decode(Crypto.self, from: data)
                let cryptoRates = crypro.data
                completion(crypro, cryptoRates)
                print(cryptoRates)
            } catch let jsonError {
                print("Ошибка получения данных:", jsonError )
            }
        }.resume()
    }
}
