//
//  Crypto.swift
//  CryptoData
//
//  Created by Егор on 11.10.2021.
//

import UIKit

struct Crypto: Decodable {
    var data: [Data]
    var info: Info
   
}

struct Data: Decodable {
    let id: String?
    let symbol: String?
    let name: String?
    let nameid: String?
    let rank: Int?
    let price_usd: String?
    let percent_change_24h: String?
    let percent_change_1h: String?
    let percent_change_7d: String?
    let price_btc: String?
    let market_cap_usd: String?
    let volume24: Double?
    let volume24a: Double?
    let csupply: String?
    let tsupply: String?
    let msupply: String?
    
    var discribtion: String {
        """
    Name: \(name ?? "")
    Rank: \(Int(rank ?? 0))
    Price USD: \(price_usd ?? "")
    Market Capitalization:
    \(market_cap_usd ?? "")
    Volume 24h:
    \(Double(round(volume24 ?? 0.0)))
    """
    }
    
}

struct Info: Decodable {
    var coins_num: Int?
    var time: Int?
}


