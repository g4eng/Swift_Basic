//
//  EditViewController.swift
//  NaviMis
//
//  Created by G4ENG on 09/02/2019.
//  Copyright © 2019 YangGaeng. All rights reserved.
//

/*
import UIKit


// 델리게이트 프로토콜 형태의 델리게이트 추가
protocol EditDelegate {
    func didMessageEditDone(_ controller: EditViewController, message: String)  // 수정화면의 메세지를 메인화면으로 보내기 위한 메소드
    func didImageOnOffDone(_ controller: EditViewController, isOn : Bool)   // 수정화면의 isOn 변수 값을 메인 화면으로 전달하기위해
    func didImageZoomDone(_ controller: EditViewController, isZoom: Bool)
}

class EditViewController: UIViewController {
    
    var textWayValue: String = ""
    var textMessage: String = ""
    var delegate: EditDelegate?
    var isOn = false    // 수정화면에서는 직접 스위치를 제어할 수 없기 때문에 똑같이 변수 선언
    var isZoom = false

    @IBOutlet var lblWay: UILabel!
    @IBOutlet var txMessage: UITextField!
    @IBOutlet var swIsOn: UISwitch!
    @IBOutlet var btnResize: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        lblWay.text = textWayValue
        txMessage.text = textMessage
        swIsOn.isOn = isOn  // isOn 값을 스위치의 On을 대입하여 스위치 값에 출력.
        if isZoom {
            btnResize.setTitle("축소", for: UIControl.State())
        }
        else {
            btnResize.setTitle("확대", for: UIControl.State())
        }
    }
    
    @IBAction func btnDone(_ sender: UIButton) {
        if delegate != nil {    // 델리게이트가 있으면 델리게이트로 텍스트 필드의 내용을 메인화면으로 전달
            delegate?.didMessageEditDone(self, message: txMessage.text!)
            delegate?.didImageOnOffDone(self, isOn: isOn)   // 전달해준다 isOn을 메인화면으로
            delegate?.didImageZoomDone(self, isZoom: isZoom)
        }
        
        _ = navigationController?.popViewController(animated: true)
    }
    
    @IBAction func swImageOnOff(_ sender: UISwitch) {
        if sender.isOn {
            isOn = true
        }
        else {
            isOn = false
        }
    }
    
    @IBAction func btnImageResize(_ sender: UIButton) {
        if isZoom {
            isZoom = false
            btnResize.setTitle("축소", for: UIControl.State())
        }
        else {
            isZoom = true
            btnResize.setTitle("확대", for: UIControl.State())
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
 */

import UIKit

protocol EditDelegate {
    func didMessageEditDone(_ controller: EditViewController, message: String)
    func didImageOnOffDone(_ controller: EditViewController, isOn: Bool)
    func didImageZoomDone(_ controller: EditViewController, isZoom: Bool)
}

class EditViewController: UIViewController {
    
    var textWayValue: String = ""
    var textMessage: String = ""
    var isOn = false
    var isZoom = false
    var delegate : EditDelegate?
    
    @IBOutlet var txMessage: UITextField!
    @IBOutlet var lblWay: UILabel!
    @IBOutlet var swIsOn: UISwitch!
    @IBOutlet var btnResize: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        lblWay.text = textWayValue
        txMessage.text = textMessage
        swIsOn.isOn = isOn
        if isZoom {
            btnResize.setTitle("확대", for: UIControl.State())
        } else {
            btnResize.setTitle("축소", for: UIControl.State())
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func btnDone(_ sender: UIButton) {
        if delegate != nil {
            delegate?.didMessageEditDone(self, message: txMessage.text!)
            delegate?.didImageOnOffDone(self, isOn: isOn)
            delegate?.didImageZoomDone(self, isZoom: isZoom)
        }
        _ = navigationController?.popViewController(animated: true)
    }
    
    @IBAction func swImageOnOff(_ sender: UISwitch) {
        if sender.isOn {
            isOn = true
        } else {
            isOn = false
        }
    }
    
    @IBAction func btnResizeImage(_ sender: UIButton) {
        if isZoom {
            isZoom = false
            btnResize.setTitle("축소", for: UIControl.State())
        } else {
            isZoom = true
            btnResize.setTitle("확대", for: UIControl.State()) 
        }
    }
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}

