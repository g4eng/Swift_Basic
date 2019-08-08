//
//  ViewController.swift
//  SubmitValue-Back
//
//  Created by G4ENG on 11/07/2019.
//  Copyright © 2019 G4ENG. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var resultEmail: UILabel!
    @IBOutlet var resultUpdate: UILabel!
    @IBOutlet var resultInterval: UILabel!
    /*
    var paramEmail: String?
    var paramUpdate: Bool?
    var paramInterval: Double?
    */
    override func viewWillAppear(_ animated: Bool) {
        /*
        if let email = paramEmail {
            resultEmail.text = email
        }
        if let update = paramUpdate {
            resultUpdate.text = update == true ? "자동갱신":"자동갱신안함"
        }
        if let interval = paramInterval {
            resultInterval.text = "\(Int(interval))분마다"
        }
         */
        
        /*
        // AppDelegate instance make
        let ad = UIApplication.shared.delegate as? AppDelegate
        
        if let email = ad?.paramEmail {
            resultEmail.text = email
        }
        if let update = ad?.paramUpdate {
            resultUpdate.text = update==true ? "자동갱신":"자동갱신안함"
        }
        if let interval = ad?.paramInterval {
            resultInterval.text = "\(Int(interval))분 마다"
        }
 */
        // UserDefault 객체를 인스턴스를 ㅏㄱ져온다
        let ud = UserDefaults.standard
        
        // if 구문을 이용한 이유는 guard를 쓰면 값이 없으면 메소드가 종료되기 떄문에
        if let email = ud.string(forKey: "email") {
            resultEmail.text = email
        }
        
        let update = ud.bool(forKey: "isUpdate")
        resultEmail.text = (update == true ? "자동갱신":"자동갱신안함")
        
        let interval = ud.double(forKey: "interval")
        resultInterval.text = "\(Int(interval))분마다"
        
        // 저장된 값의 타입이 어떤 것인지 정확하게 알기 어렵거나 메소드를 공용으로 사용할 때에는 범용 데이터 타입을 반환하는 메소드를 사용해도 된다. 이 메소드는 Any타입을 반환하기 때문에 다음과 같은 식으로 캐스팅해서 사용하면 됨
        // let email = ud.value(forkey: "email") as? String
        // or
        // let email = ud.object(forKey: "email") as? String
        // 둘다 any타입의 값을 반환하는 메소드다. 문자열부터 논리형, 실수 등 모든 타입의 값을 읽어올 수 있지만, 항상 옵셔널 타입으로 반환하기 때문에 주의하자
        // UserDefaults 값은 앱을 제거하기 전까지는 값이 저장된다.
    }
}

