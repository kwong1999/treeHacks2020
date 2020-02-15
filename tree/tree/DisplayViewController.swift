//
//  DisplayViewController.swift
//  tree
//
//  Created by Kelly Dickson on 2/15/20.
//  Copyright © 2020 Katie Wong. All rights reserved.
//

import UIKit

class DisplayViewController: UIViewController {

    @IBOutlet weak var label: UILabel!
    var finalName = ""
    var response = ""
    
    
    
    
    @IBOutlet weak var json: UILabel!
    
    func changeResponse(s: String){
        self.response = s
        print(self.response)
        DispatchQueue.main.async {
            self.json.text = self.response
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        label.text = finalName
        let url = URL(string: "https://npin.cdc.gov/api/organization/proximity?prox[origin]=07060")
        let session = URLSession.shared // or let session = URLSession(configuration: URLSessionConfiguration.default)
        if let usableUrl = url {
            let task = session.dataTask(with: usableUrl, completionHandler: { (data, response, error) in
                if let data = data {
                    if let stringData = String(data: data, encoding: String.Encoding.utf8) {
                        self.response = (stringData) //JSONSerialization
                        //print(stringData)
                        self.changeResponse(s: stringData)
                        
                    }
                }
            })
            task.resume()
        }
        //print(response)
        self.json.text = response
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
