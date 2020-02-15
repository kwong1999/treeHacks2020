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
    
    var option = ""
    var pickerData: [String] = [String]()
    @IBOutlet weak var picker: UIPickerView!
    override func viewDidLoad() {
        super.viewDidLoad()
        pickerData = ["Acute HIV Testing","Chlamydia Testing","Conventional Blood HIV Testing","Conventional Oral HIV Testing","Gonorrhea Testing","Hepatitis A Testing","Hepatitis B Testing","Hepatitis C Testing","Hepatitis Testing","Herpes Testing","HIV Testing","Rapid Blood HIV Testing","Rapid Oral HIV Testing","STD Testing","Syphilis Testing","TB Testing"]
        picker.delegate = self
        picker.dataSource = self
        //picker.selectRow(4, inComponent: 0, animated: true)
        
        // Do any additional setup after loading the view.
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        var vc = segue.destination as! DisplayViewController
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
