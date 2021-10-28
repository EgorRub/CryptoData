//
//  MainTableViewController.swift
//  CryptoData
//
//  Created by Егор on 11.10.2021.
//

import UIKit

class MainTableViewController: UITableViewController {
    
    private var cryptoRates: [Data] = []
    private var spinnerView: UIActivityIndicatorView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = 65
        spinnerView = showSpinner(in: tableView)
        sendRequest()
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        cryptoRates.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CryptoTableViewCell
        let cryptoRates = cryptoRates[indexPath.row]
        
        cell.symbolLabel.text = cryptoRates.symbol
        cell.currentPriceLabel.text = "$\(cryptoRates.price_usd ?? "")"
        
        cell.percentageChangeLabel.text = "\(cryptoRates.percent_change_24h ?? "")%"
        
        let percentChange24h = cryptoRates.percent_change_24h ?? ""
        let percentDouble = (Double(percentChange24h) ?? 0.0)
        if percentDouble > 0.0 {
            
            cell.percentageChangeLabel.textColor = .systemGreen
            cell.cryptoImageView.image = UIImage(systemName: "arrow.up")
            
        } else if percentDouble < 0.0 {
            
            cell.percentageChangeLabel.textColor = .systemRed
            cell.cryptoImageView.image = UIImage(systemName: "arrow.down")
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }



    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let detailsVC = segue.destination as? CryptoDetailsViewController else { return }
        guard let indexPath = tableView.indexPathForSelectedRow else { return }
            let cryptoRate = cryptoRates[indexPath.row]
            detailsVC.cryptoData = cryptoRate
    }

    
    @IBAction func updateInformationButtonAction(_ sender: UIBarButtonItem) {
        spinnerView?.startAnimating()
        sendRequest()
    }
    

}

extension MainTableViewController {
    private func sendRequest() {
        NetworkManager.shared.fetchData { crypto, cryptoRates in
            DispatchQueue.main.async {
                self.spinnerView?.stopAnimating()
                for cryptoRate in cryptoRates {
                    self.cryptoRates.append(cryptoRate)
                }
                self.tableView.reloadData()
                self.title = "List of Cryptocurrencies"
            }
        }
        
    }
    
    private func showSpinner(in view: UIView) -> UIActivityIndicatorView {
        let activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.color = .darkGray
        activityIndicator.startAnimating()
        activityIndicator.center = view.center
        activityIndicator.hidesWhenStopped = true
        
        view.addSubview(activityIndicator)
        
        return activityIndicator
    }
    
    
    
}
