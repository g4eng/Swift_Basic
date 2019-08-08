//
//  ViewController.swift
//  modalView
//
//  Created by G4ENG on 25/02/2019.
//  Copyright © 2019 G4ENG. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func experiment(_ sender: UIButton) {
        let nextController = UIImagePickerController()
        self.present(nextController, animated: false, completion: nil)
    }
    
}

