//
//  CryptoDetailsViewController.swift
//  CryptoData
//
//  Created by Егор on 12.10.2021.
//

import UIKit

class CryptoDetailsViewController: UIViewController {
    
    var cryptoData: Data!
    
    @IBOutlet weak var symbolLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var rankLabel: UILabel!
    @IBOutlet weak var priceUSDLabel: UILabel!
    @IBOutlet weak var marketCapitalizationLabel: UILabel!
    @IBOutlet weak var volume24hLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        symbolLabel.text = "Ticker: \(cryptoData.symbol ?? "")"
        nameLabel.attributedText = "Name: \(cryptoData.name ?? "")".withBoldText(text: "Name:")
        rankLabel.attributedText = "Rank: \(cryptoData.rank ?? 0)".withBoldText(text: "Rank:")
        priceUSDLabel.attributedText = "Price USD: \(cryptoData.price_usd ?? "")".withBoldText(text: "Price USD:")
        marketCapitalizationLabel.attributedText = "Market Capitalization: \(cryptoData.market_cap_usd ?? "")".withBoldText(text: "Market Capitalization:")
        volume24hLabel.attributedText = "Volume 24h: \(round(cryptoData.volume24 ?? 0.0))".withBoldText(text: "Volume 24h:")
    }

}


extension String {
func withBoldText(text: String, font: UIFont? = nil) -> NSAttributedString {
  let _font = font ?? UIFont.systemFont(ofSize: 20, weight: .regular)
  let fullString = NSMutableAttributedString(string: self, attributes: [NSAttributedString.Key.font: _font])
  let boldFontAttribute: [NSAttributedString.Key: Any] = [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: _font.pointSize)]
  let range = (self as NSString).range(of: text)
  fullString.addAttributes(boldFontAttribute, range: range)
  return fullString
    }
}
