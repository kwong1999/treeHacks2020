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
    
    struct Person: Codable {
        var field_org_nid: String
        var field_org_id : String
        var title_field : String
        var field_org_street1 : String
        var field_org_street2 : String
        var field_org_city_name : String
        var field_org_county : String
        
        var field_org_state : String
        var field_org_zipcode : String
        var field_org_country : String
        var field_org_phone : String
        var field_org_lat_long : String
        var  field_org_distance : String
        var field_org_last_updated : String
        
        var field_org_svc_testing : String
        var field_org_svc_prevention : String
        var field_org_svc_capacity : String
        var field_org_svc_care : String
        var field_org_svc_support : String
        var  field_audiences : String
        var field_organization_languages : String
        
        var field_npin_link : String
        var field_organization_hours : String
        var field_organization_eligibilty : String
        var field_org_fee : String
        var last_updated : String
        var  field_org_type : String
        var field_org_websites : String
        init()
        {
            field_org_nid = ""
            field_org_id = ""
            title_field = ""
            field_org_street1 = ""
            field_org_street2 = ""
            field_org_city_name = ""
            field_org_county = ""
            
            field_org_state = ""
            field_org_zipcode = ""
            field_org_country = ""
            field_org_phone = ""
            field_org_lat_long = ""
            field_org_distance = ""
            field_org_last_updated = ""
            
            field_org_svc_testing = ""
            field_org_svc_prevention = ""
            field_org_svc_capacity = ""
            field_org_svc_care = ""
            field_org_svc_support = ""
            field_audiences = ""
            field_organization_languages = ""
            
            field_npin_link = ""
            field_organization_hours = ""
            field_organization_eligibilty = ""
            field_org_fee = ""
            last_updated = ""
            field_org_type = ""
            field_org_websites = ""
                  
        }
    }
    
    func changeResponse(s: Data){
        DispatchQueue.main.async {
           // self.json.text = self.response
            
            let decoder = JSONDecoder()
            
            do {
                let people = try decoder.decode([Person].self,from:s)
                print(people)
                self.json.text = people[0].field_org_city_name
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        label.text = finalName
        /*let url = URL(string: "https://npin.cdc.gov/api/organization/proximity?prox[origin]=07060")
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
        }*/
        let urlString = URL(string: "https://npin.cdc.gov/api/organization/proximity?prox[origin]=07060")
        if let url = urlString {
             let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
             if error != nil {
                  print(error)
             } else {
                  if let usableData = data {
                       self.changeResponse(s: usableData) //JSONSerialization
                       }
                  }
             }
        task.resume()
        //print(response)
        //self.json.text = response
    }
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
