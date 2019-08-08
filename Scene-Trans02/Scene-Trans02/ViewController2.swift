//
//  SecondViewController.swift
//  Scene-Trans02
//
//  Created by G4ENG on 08/07/2019.
//  Copyright © 2019 G4ENG. All rights reserved.
//

import UIKit

class ViewController2: UIViewController {
    @IBAction func back(_ sender: Any) {
        self.presentingViewController?.dismiss(animated: true)
    }
    @IBAction func back2(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}
