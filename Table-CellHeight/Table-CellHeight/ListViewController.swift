//
//  ListViewController.swift
//  Table-CellHeight
//
//  Created by G4ENG on 25/07/2019.
//  Copyright © 2019 G4ENG. All rights reserved.
//

import UIKit

class ListViewController: UITableViewController {
    // 테이블 뷰에 연결될 데이터를 저장할 배열
    var list = [String]()
    
    // 가로 행 수 결정
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.list.count
    }
    
    // 가로행 내용 결정
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // 1. cell 아이디를 가진 셀을 읽어온다
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") ?? UITableViewCell()
        
        // 추가 부분) 셀의 기본 텍스트 레이블 행 수 제한을 없앤다
        cell.textLabel?.numberOfLines = 0
        
        // 셀의 기본 텍스트 레이블에 배열 변수의 값을 할당
        cell.textLabel?.text = list[indexPath.row]
        return cell
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tableView.estimatedRowHeight = 50
        self.tableView.rowHeight = UITableView.automaticDimension
    }
    
    /*
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let row = self.list[indexPath.row]
        
        // 높이를 조절해준다 : 기본 높이 + 글의 길이가 30자가 넘어갈때 마다 20만큼씩 높아진다
        let height = CGFloat(60 + (row.count / 30) * 20)
        return height
    }
    */
    
    @IBAction func add(_ sender: Any) {
        // 알림창 만들기
        let alert = UIAlertController(title: "목록 입력", message: "추가될 글을 작성해주세요", preferredStyle: .alert)
        
        // 입력폼 추가
        alert.addTextField() { (tf) in
            tf.placeholder = "내용을 입력하세요"
        }
        
        // ok 버튼 객체를 생성한다. 아직 알림창 객체에 버튼이 등록되지 않은 상태
        let ok = UIAlertAction(title: "OK", style: .default) { (_) in
            // 알림창의 0번째 입려필드에 값이 있다면
            if let title = alert.textFields?[0].text {
                // 배열에 추가하고 테이블 갱신
                self.list.append(title)
                self.tableView.reloadData()
            }
        }
        // 취소 버튼 객체 생성
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        // 버튼 등록
        alert.addAction(ok)
        alert.addAction(cancel)
        
        // 알림창 띄우기
        self.present(alert, animated: false)
    }
}
