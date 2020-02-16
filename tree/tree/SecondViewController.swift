//
//  SecondViewController.swift
//  tree
//
//  Created by Kelly Dickson on 2/15/20.
//  Copyright © 2020 Katie Wong. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[row]
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)  {
        option = pickerData[row] as String
    }
    
    @IBOutlet weak var whiteView: UIView!
    var option = ""
    var pickerData: [String] = [String]()
    @IBOutlet weak var picker: UIPickerView!
    override func viewDidLoad() {
        super.viewDidLoad()
        pickerData = ["Chlamydia Testing","Conventional Blood HIV Testing","Gonorrhea Testing","Hepatitis A Testing","Hepatitis B Testing","Hepatitis C Testing","Herpes Testing","Rapid Blood HIV Testing","Rapid Oral HIV Testing","Syphilis Testing","TB Testing"]
        picker.delegate = self
        picker.dataSource = self
        //picker.selectRow(4, inComponent: 0, animated: true)
        
        // Do any additional setup after loading the view.
        
        button.layer.cornerRadius = 5
        button.clipsToBounds = true
        
        whiteView.layer.cornerRadius = 5;
        whiteView.layer.masksToBounds = true;
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        var vc = segue.destination as! DisplayViewController
        if(self.option == "")
        {
            self.option = "Chlamydia Testing"
        }
        vc.finalName = self.option
    }
    
    @IBOutlet weak var button: UIButton!
    
    @IBAction func buttonClick(_ sender: Any) {
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
