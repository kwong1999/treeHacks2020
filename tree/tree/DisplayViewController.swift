//
//  DisplayViewController.swift
//  tree
//
//  Created by Kelly Dickson on 2/15/20.
//  Copyright © 2020 Katie Wong. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit

class DisplayViewController: UIViewController {

    @IBOutlet weak var label: UILabel!
    var finalName = ""
    var response = ""
    var postalCode = ""
    var lat :CLLocationDegrees = 0
    var lon :CLLocationDegrees = 0
    
    
    @IBOutlet weak var map: MKMapView!
    
    @IBOutlet weak var json: UILabel!
    
    @IBOutlet weak var info: UILabel!
    
    @IBOutlet weak var services: UILabel!
    
    @IBOutlet weak var clinic: UILabel!
    struct Provider: Codable {
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
        var field_org_distance : String
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
        var field_org_type : String
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
    let regionRadius: CLLocationDistance = 1000
    func centerMapOnLocation(location: CLLocation) {
        let coordinateRegion = MKCoordinateRegion.init(center: location.coordinate,
                                                       latitudinalMeters: regionRadius, longitudinalMeters: regionRadius)
        map.setRegion(coordinateRegion, animated: true)
    }
    
    
    func lookUpCurrentLocation() {
        // Use the last reported location.
            if let lastLocation = self.locationManager.location {
                let geocoder = CLGeocoder()
                
                geocoder.reverseGeocodeLocation(lastLocation,
                completionHandler: { (placemarks, error) in
                    if error == nil {
                        let firstLocation = placemarks?[0] as! CLPlacemark!
                        self.postalCode = firstLocation?.postalCode as! String
                    }
                })
            }
    }
    
    func changeResponse(s: Data){
        DispatchQueue.main.async {
           // self.json.text = self.response
            
            let decoder = JSONDecoder()
            
            do {
                let providers = try decoder.decode([Provider].self,from:s)
                //print(providers)
                var arrayChoice = [Provider]()
                var distChoice = [Double]()
                /*if providers.count == 0 {
                    self.json.text = "Could not find a match."
                }
                else {*/
                    var distance = [(name: Int, value: Double)]()
                    for count in 0...(providers.count-1){
                        let coordinate₀ = CLLocation(latitude: self.lat, longitude: self.lon)
                        let indLat = providers[count].field_org_lat_long.firstIndex(of: ",")!
                        let pLat = Double(String(providers[count].field_org_lat_long[..<indLat]))
                        let tempString = String(providers[count].field_org_lat_long[indLat...])
                        let indLon = tempString.index(tempString.startIndex, offsetBy: 2)
                        let pLon = Double(String(tempString[indLon...]))
                        let coordinate₁ = CLLocation(latitude: pLat!, longitude: pLon!)
                        distance.append((name: count, value: Double(coordinate₀.distance(from: coordinate₁))))
                        
                    }
                distance = distance.sorted(by: {$0.0 < $1.0})
                for dist in distance{
                    if(providers[dist.name].field_org_fee.contains("Free") || providers[dist.name].field_org_fee.contains("Medicaid"))
                    {
                        arrayChoice.append(providers[dist.name])
                        distChoice.append(dist.value/1609.0)
                        //print(dist.value/1609.0)
                    }
                }
                
                
                    
                    /*self.json.text = providers[0].field_org_city_name
                    self.services.text = providers[0].field_org_svc_testing
                    self.clinic.text = providers[0].title_field*/
               // }
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    var locationManager = CLLocationManager()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.requestWhenInUseAuthorization()
        var currentLoc: CLLocation!
        if(CLLocationManager.authorizationStatus() == .authorizedWhenInUse ||
            CLLocationManager.authorizationStatus() == .authorizedAlways) {
            currentLoc = locationManager.location
           lat = currentLoc.coordinate.latitude
           lon = currentLoc.coordinate.longitude
            print(lat)
            print(lon)
        }
        centerMapOnLocation(location: currentLoc)
        
        
        lookUpCurrentLocation()
        label.text = finalName
        
        var startUrl = ""
        DispatchQueue.main.asyncAfter(deadline: .now()+0.5) { //this may be too slow
           // Code you want to be delayed
            startUrl = "https://npin.cdc.gov/api/organization/proximity?prox[origin]=\(self.postalCode)&svc_testing="
            //print(startUrl)
            
            if self.finalName == "Chlamydia Testing" {
                self.info.text = "Chlamydia is a common sexually transmitted disease that is most detrimental to women. It can permanently damage the female reproductive system and cause pelvic inflammatory disease (PID) if not properly treated. Tests include a urine test or (for women) a swab from your cervix. For women, yearly screening is recommended if you are sexually active."
                startUrl += "Chlamydia%20Testing"
            }
            else if self.finalName == "Conventional Blood HIV Testing" {
                self.info.text = "Human immunodeficiency virus (HIV) targets healthy T cells in the body, leaving the body susceptible to infections and cancer. While there is currently no cure for HIV, with proper treatment it can be managed. Blood is extracted, taken to the lab, and results are given in a few hours to a few days."
                startUrl += "Conventional%20Blood%20HIV%20Testing"
            }

            else if self.finalName == "Gonorrhea Testing" {
                self.info.text = "Gonorrhea is a sexually transmitted disease that most commonly affects young men and women between the ages 15-24. It can be spread through unprotected vaginal, anal, or oral sex. Typically, a urine test is performed."
                startUrl += "Gonorrhea%20Testing"
            }
            else if self.finalName == "Hepatitis A Testing"{
                self.info.text = "Hepatitis A is a highly contagious liver infection that is contracted by unknowingly ingesting the virus from miniscule amounts of stool of an uninfected person. Unlike Hepatitis B and C, Hepatitis A is usually short-term. Typically, a blood test is performed."
                startUrl += "Hepatitis%20A%20Testing"
            }
            else if self.finalName == "Hepatitis B Testing" {
                self.info.text = "Hepatitis B is a liver infection that can be passed through blood, semen, or other bodily fluids of an infected person. While Hepatitis B is typically short-term, for people with weak immune systems it can become chronic. Typically, a blood test is performed."
                startUrl += "Hepatitis%20B%20Testing"
            }
            else if self.finalName == "Hepatitis C Testing"{
                self.info.text = "Hepatitis C is a blood-borne liver infection that most often turns into a chronic diagnosis and can lead to many long-term health problems. It is most commonly transmitted by sharing needles. Typically, a blood test is performed."
                startUrl += "Hepatitis%20C%20Testing"
            }
           
            else if self.finalName == "Herpes Testing" {
                self.info.text = "There are two types of herpes–genital herpes and oral herpes. They can result in cold sores and blisters around the genital area and the mouth, respectively. Most people with herpes exhibit no symptoms or only very mild symptoms. Tests are done by extracting fluid or cells for cell culture near the infection."
                startUrl += "Herpes%20Testing"
            }
            
            else if self.finalName == "Rapid Blood HIV Testing"{
                self.info.text = "Human immunodeficiency virus (HIV) targets healthy T cells in the body, leaving the body susceptible to infections and cancer. While there is currently no cure for HIV, with proper treatment it can be managed. The test is performed with 99% accuracy. It takes 20 minutes and can detect HIV 18-45 days after infected."
                startUrl += "Rapid%20Blood%20HIV%20Testing"
            }
            else if self.finalName == "Rapid Oral HIV Testing"{
                self.info.text = "Human immunodeficiency virus (HIV) targets healthy T cells in the body, leaving the body susceptible to infections and cancer. While there is currently no cure for HIV, with proper treatment it can be managed. Results from this test are given 15-20 minutes after it is taken. This test is not as reliable during the window period, first couple weeks or months, after infected."
                startUrl += "Rapid%20Oral%20HIV%20Testing"
            }
            else if self.finalName == "Syphilis Testing" {
                self.info.text = "Syphilis is a sexually transmitted disease spread through direct contact during vaginal, anal, oral sex and can lead to serious health complications if left untreated. There are four different stages (primary, secondary, latent, and tertiary) with different symptoms. Typically, this is done via blood test."
                startUrl += "Syphilis%20Testing"
            }
            else if self.finalName == "TB Testing" {
                self.info.text = "Tuberculosis (TB) is an infectious disease mainly targeting the lungs, but it can also affect the kidney, spine, and brain. It’s spread through the air in coughs and sneezes. There are two forms–active TB and latent TB. TB is tested via blood test or skin test. Skin test involves injecting a small amount of liquid into your skin and checking for a reaction within a couple days."
                startUrl += "TB%20Testing"
            }
            
           // print(startUrl)
            
            let urlString = URL(string: startUrl)
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
        }
            
        
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
