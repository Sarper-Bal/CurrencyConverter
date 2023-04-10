//
//  ViewController.swift
//  CurrencyConverter
//
//  Created by Sarper Bal on 10.04.2023.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var cadLabel: UILabel!
    @IBOutlet weak var chflabel: UILabel!
    @IBOutlet weak var gbpLabel: UILabel!
    @IBOutlet weak var usdLabel: UILabel!
    @IBOutlet weak var tryLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
            }

    @IBAction func getGetirClicked(_ sender: Any) {
        
        //1) Request & Session
        //2) Response & Data
        //3) Parsing & JSON Serilization
        
        // 1
        let url = URL(string: "https://raw.githubusercontent.com/atilsamancioglu/CurrencyData/main/currency.json")
        
        let session = URLSession.shared
        
        //Closure
        let task = session.dataTask(with: url!) { data, response, error in
            if error != nil {
                let alert = UIAlertController(title: "ERROR", message: error?.localizedDescription, preferredStyle: UIAlertController.Style.alert)
                let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default)
                alert.addAction(okButton)
                self.present(alert, animated: true)
            } else {
                // 2
                if data != nil {
                    
                    do{
                        let jasonResponse = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as! Dictionary<String, Any>
                        
                        
                        //ASYNC
                        DispatchQueue.main.async {
                            if let rates = jasonResponse["rates"] as? [String : Any] {
                                
                                if let cad = rates["CAD"] as? Double {
                                    self.cadLabel.text = "CAD  : \(cad)"
                                }
                                
                                if let chf = rates["CHF"] as? Double {
                                    self.chflabel.text = "CHF : \(chf)"
                                }
                                
                                if let gbh = rates["GBP"] as? Double {
                                    self.gbpLabel.text = "GBP : \(gbh)"
                                }
                                
                                if let usd = rates["USD"] as? Double {
                                    self.usdLabel.text = "USD : \(usd)"
                                }
                                
                                if let tryy = rates["TRY"] as? Double {
                                    self.tryLabel.text = "TRY : \(tryy)"
                                }
                            }
                        }
                        
                    } catch {
                        print("error")
                    }
                        
                }
                
            }
        }
        task.resume()
    }
    
}

