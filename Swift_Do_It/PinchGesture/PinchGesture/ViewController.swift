//
//  ViewController.swift
//  PinchGesture
//
//  Created by G4ENG on 22/02/2019.
//  Copyright © 2019 G4ENG. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
 
    @IBOutlet var imgView: UIImageView!
    
    var initialFontSize: CGFloat!
    // 핀치 제스처가 발생했을 때 현재 글자 크기를 저장하는 변수
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    
        let pinch = UIPinchGestureRecognizer(target: self, action: #selector(ViewController.doPinch(_:)))
        self.view.addGestureRecognizer(pinch)
    }

    @objc func doPinch(_ pinch: UIPinchGestureRecognizer) {
        if (pinch.state == UIGestureRecognizer.State.began) {
            // 핀치 제스처의 상태를 state 속성을 사용하여 확인
            imgView.transform = imgView.transform.scaledBy(x: pinch.scale, y: pinch.scale)
            pinch.scale = 1
        }
    }
}

