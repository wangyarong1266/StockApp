//
//  AddStockViewController.swift
//  StockApp
//
//  Created by Tianxiang Gao on 10/21/23.
//

import UIKit
import Alamofire
import SwiftyJSON

class AddStockViewController: UIViewController {

    @IBOutlet weak var txtStock: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func addStockAction(_ sender: Any) {
        guard let stockSymbol = txtStock.text else { return }
        
        let url = "\(baseUrl)profile/\(stockSymbol.uppercased())?apikey=\(apiKey)"
        
        AF.request(url).responseJSON { response in
            if (response.error != nil) {
                print(response.error?.localizedDescription)
                return
            }
            
            guard let rawData = response.data else { return }
            guard let jsonArray = JSON(rawData).array else { return }
            guard let stock = jsonArray.first else { return }
            
            let symbol = stock["symbol"].stringValue
            let price = stock["price"].floatValue
            let companyName = stock["companyName"].stringValue
            let description = stock["description"].stringValue
            
            print(symbol)
            print(price)
            print(companyName)
            print(description)
        }
    }
    
}
