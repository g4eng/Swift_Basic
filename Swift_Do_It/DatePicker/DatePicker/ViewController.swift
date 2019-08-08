//
//  ViewController.swift
//  DatePicker
//
//  Created by YangGaeng on 05/01/2019.
//  Copyright © 2019 YangGaeng. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    let timeSelector: Selector = #selector(ViewController.updateTime)
    // timeSelector : 타이머가 구동되면 실행할 함수를 지정
    let interval = 1.0
    // 타이머의 간격 값 1.0은 1초를 의미
    var count = 0
    // 타이머가 설정한 간격대로 실행되는지 확인하기 위한 변수
    
    
    @IBOutlet weak var lblCurrentTime: UILabel!
    @IBOutlet weak var lblPickerTime: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        Timer.scheduledTimer(timeInterval: interval, target: self, selector: timeSelector, userInfo : nil, repeats: true)
        // timeInterval : 타이머 간격, target: 동작될 view, selector: 타이머가 구동될 때 실행할 함수, userInfo: 사용자 정보, repeats: 반복 여부
    }
    @IBAction func changeDatePicker(_ sender: UIDatePicker) {
        let datePickerView = sender
        // 데이트 피커를 선택할 때 발생하는 액션 함수인 changeDatePicker가 호출되면서 sender라는 UIDatePicker 자료형의 인수가 전달됩니다. 이 sender를 datePickerView에 저장
        let formatter = DateFormatter()
        // 날짜를 출력하기 위하여 DateFormatter라는 클래스 상수 formatter를 선언
        formatter.dateFormat="yyyy MM dd HH:mm:ss EEE"
        // formatter의 dateFormat 속성을 설정한다
        lblPickerTime.text =
        "선택 시간 : " + formatter.string(from: datePickerView.date)
        // 데이트 피커에서 선택한 날짜를 formatter의 dateFormate에서 설정한대로 string 메서드를 사용하여 문자열로 변환해서 lblPickerTime에 넣음
        
    }
    @objc func updateTime(){
        // Swift4에서는 #selector()의 인자로 사용될 메소드를 선언할 때 Objective-C와의 호환성을 위하여 함수 앞에 반드시 @objc 키워드를 붙여줘야한다.
        // lblCurrentTime.text = String(count)
        // Stirng으로 변환한 count의 값을 라벨의 text속성에 저장
        // count += 1
        
        let date = NSDate() // 현재 시간을 NSDate 함수를 사용하여 가져옴
        
        let formatter = DateFormatter() //날짜를 출력하기 위해 객체 선언
        formatter.dateFormat="yyyy MM dd HH:mm:ss EEE"    // formatter 형식 지정
        lblCurrentTime.text =
        "현재 시간 : " + formatter.string(from: date as Date)
        // formatter.string(date)는 피커 뷰에서 선택한 날짜를 formatter의 dateFormat에서 설정한 포맷대로 string메서드를 사용하여 문자열로 변환ㄱ
    }
    

}

