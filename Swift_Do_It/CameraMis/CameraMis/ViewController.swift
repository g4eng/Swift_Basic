//
//  ViewController.swift
//  CameraMis
//
//  Created by G4ENG on 18/02/2019.
//  Copyright © 2019 YangGaeng. All rights reserved.
//

import UIKit
import MobileCoreServices   // 다양한 타입들을 정의해 놓은 헤더 파일 추가

class ViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {

    @IBOutlet var imgView1: UIImageView!
    @IBOutlet var imgView2: UIImageView!
    @IBOutlet var imgView3: UIImageView!
    
    let imagePicker: UIImagePickerController! = UIImagePickerController()
    // UIImagePickerController 인스턴스 변수 생성
    var captureImage: UIImage! // 사진을 저장할 변수
    var flagSaveImage = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func btnCaptureImage(_ sender: UIButton) {
    }
    
    @IBAction func btnLoadImage(_ sender: UIButton) {
    }
    
    @IBAction func btnReset(_ sender: UIButton) {
    }
    
    func myAlert(_ title: String, message: String) {
        let errorAlert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        let errorAction = UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil)
        
        errorAlert.addAction(errorAction)
        self.present(errorAlert, animated: true, completion: nil)
    }
}

