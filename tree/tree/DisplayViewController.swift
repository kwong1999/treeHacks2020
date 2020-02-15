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
    override func viewDidLoad() {
        super.viewDidLoad()
        label.text = finalName

        // Do any additional setup after loading the view.
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
