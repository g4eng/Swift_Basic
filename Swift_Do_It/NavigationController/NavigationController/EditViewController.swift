//
//  EditViewController.swift
//  NavigationController
//
//  Created by G4ENG on 25/02/2019.
//  Copyright © 2019 G4ENG. All rights reserved.
//

import UIKit

class EditViewController: UIViewController {
    @IBOutlet var lblWay: UILabel!
    
    var textWayValue: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        lblWay.text = textWayValue
    }
    
    @IBAction func btnDone(_ sender: UIButton) {
        _ = navigationController?.popViewController(animated: true)
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
