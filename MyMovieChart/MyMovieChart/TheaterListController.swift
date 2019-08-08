//
//  TheaterListController.swift
//  MyMovieChart
//
//  Created by G4ENG on 29/07/2019.
//  Copyright © 2019 G4ENG. All rights reserved.
//

import UIKit

class TheaterListController: UITableViewController {
    // API를 통해 불러온 데이터를 저장할 배열 변수
    // 배열에 저장될 객체 타입이 NSDictionary라는 제네릭 선언, 제네릭을 통하여 배열을 선언하면 배열에 들어가는 데이터 형식이 고정되므로 나중에 값을 꺼낼 때 캐스팅하지 않아도 됨
    var list = [NSDictionary]()
    
    // 읽어올 데이터의 시작 위치
    // 이번 API에서 제공하는 데이터 구조는 이전의 영화 차트 API와는 약간 다르다. 읽어올 데이터의 시작 위치를 직접 지정해야 한다. 이것과 관련하여 읽어올 데이터의 위치를 계산하는 코드는 뒤에서 따로 살펴보자. 지금은 데이터의 위치가 0에서 시작된다는 것만 기억하자
    var startPoint = 0
    
    @IBOutlet var moreBtn: UIButton!
    @IBAction func more(_ sender: Any) {
        self.callTheaterAPI()
        
        self.tableView.reloadData()
    }
    
    override func viewDidLoad() {
        // API를 호출
        self.callTheaterAPI()
    }
    
    // API로 부터 극장 정보를 읽어오는 메소드
    func callTheaterAPI() {
        // 1. URL을 구성하기 위한 상수값을 선언
        let requestURI = "http://swiftapi.rubypaper.co.kr:2029/theater/list"    // api 요청 주소
        let sList = 100 // 불러올 갯수
        let type = "json"   // 데이터 형식
        
        // 2. 인자값들을 모아 URL 객체로 정의
        let urlObj = URL(string: "\(requestURI)?s_page=\(self.startPoint)&s_list=\(sList)&type=\(type)")
        
        do {
            // 3. NSString 객체를 이용하여 API를 호출하고 그 결과값을 인코딩된 문자열로 받아온다
            // 영화관 목록은 EUC-KR로 인코딩 되어있다. 그래서 데이터를 읽어올 때 인코딩 처리를 해야 한다. Data 객체 대신 NSString 객체를 이용하여 API 데이터를 읽어오는 것은 이 때문. NSString은 인코딩 처리가 가능한 구문을 지원함
            // 인자값으로 들어간 0x80_000_422는 EUC-KR 인코딩에 해당하는 16진수 값. 값사이에 들어간 언 더바는 자리수를 알아보기 쉽게 나눈 것.
            let stringdata = try NSString(contentsOf: urlObj!, encoding: 0x80_000_422)
            
            // 4. 문자열로 받은 데이터를 UTF-8로 인코딩처리한 Data로 변환
            // NSString으로 데이터를 읽어오면 Data 객체와 달리 문자열 형태로 반환함. 우리가 사용할 데이터 타입은 Data이므로, 다시 타입을 바꿔준다. 인코딩 타입은 UTF-8로 인코딩 처리한다
            let encData = stringdata.data(using: String.Encoding.utf8.rawValue)
            do {
                // 5. Data 객체를 파싱하여 NSArray 객체로 변환
                // JSON 형태로 읽어온 Data 객체를 JSONSerialization 객체를 사용해 NSArray로 파싱하는 과정
                let apiArray = try JSONSerialization.jsonObject(with: encData!, options: []) as? NSArray
                // 6. 읽어온 데이터를 순회하면서 self.list 배열에 추가
                // NSArray 배열 형태로 변환된 데이터를 for문을 돌려 list에 넣어준다
                for obj in apiArray! {
                    self.list.append(obj as! NSDictionary)
                }
            }
            catch {
                // 경고창 형식으로 오류 메시지를 표시해준다
                let alert = UIAlertController(title: nil, message: "데이터 분석이 실패하였습니다", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "확인", style: .cancel, handler: nil))
                self.present(alert, animated: false)
            }
            // 7. 읽어 와야할 다음 페이지의 데이터 시작 위치를 구해 저장해둔다
            // callTheaterAP()가 재호출되었을 때 동일한 데이터 범위를 다시 읽어오는 대신 그 다음 범위를 읽어올 수 있도록 처리하는 구문
            // do~try 블록 밖에 선언한 이유는 읽어온 데이터 블록의 내용이 일부 잘못되어 파싱이 실패하더라도 다음 범위의 데이터를 정상적으로 읽어올 수 있도록 하기 위함
            self.startPoint += sList
            
            // page가 355 이상이 되면 더이상 버튼 잠금
            if self.startPoint >= 355 {
                self.moreBtn.isEnabled = false
                self.moreBtn.setTitle("마지막 목록입니다", for: .disabled)
            }
        }
        catch {
            // 경고창 형식으로 오류 메시지를 표시해준다
            let alert = UIAlertController(title: nil, message: "데이터 분석이 실패하였습니다", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "확인", style: .cancel, handler: nil))
            self.present(alert, animated: false)
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.list.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // self.list 배열에서 행에 맞는 데이터를 꺼냄
        let obj = self.list[indexPath.row]
        
        // 재사용 큐로부터 tCell 식별자에 맞는 셀 객체를 전달 받음
        let cell = tableView.dequeueReusableCell(withIdentifier: "tCell") as! TheaterCell
        
        cell.name?.text = obj["상영관명"] as? String
        cell.tel?.text = obj["연락처"] as? String
        cell.addr?.text = obj["소재지도로명주소"] as? String
        
        return cell
    }
    
    // 세그웨이 전처리 메소드
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "segue_map") {
            // 선택된 셀의 행 정보
            let path = self.tableView.indexPath(for: sender as! UITableViewCell)
            // 선택된 셀에 사용된 데이터
            let data = self.list[path!.row]
            // 세그웨이가 이동할 목적지 뷰 컨트롤러 객체를 구하고, 선언된 param 변수에 데이터를 연결
            (segue.destination as? TheaterViewController)?.param = data
        }
    }
}
