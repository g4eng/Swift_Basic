//
//  TableViewController.swift
//  Table
//
//  Created by YangGaeng on 07/02/2019.
//  Copyright © 2019 YangGaeng. All rights reserved.
//

import UIKit

var items = ["책 구매", "철수와 약속", "스터디 준비하기"]
var itemsImageFile = ["cart.png", "clock.png", "pencil.png"]

class TableViewController: UITableViewController {

    @IBOutlet var tvListView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        self.navigationItem.leftBarButtonItem = self.editButtonItem         // bar button 으로 목록 삭제 동작 코딩
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tvListView.reloadData()
    }
    // 새 목록 추가
    
    // viewDidLoad, viewWillAppear, ViewDidAppear 이 세개는 뷰가 보일 때 호출되는 함수들이다.

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    // normally section in table is one so numberOfSections's return value is 1
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return items.count
    }
    // rows of section is as same as items so tableView method return value is items.count

    
    // 왜 주석 처리된 함수를 제공해요?
    // UI 테이블 뷰 컨트롤러는 상속받은 컨트롤러가 자주 사용하는 함수를 주석 처리하여 미리 제공한다.
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath)

        cell.textLabel?.text = items[(indexPath as NSIndexPath).row]
        // 셀의 텍스트 레이블에 앞에서 선언한 items을 대입한다.
        cell.imageView?.image = UIImage(named: itemsImageFile[(indexPath as NSIndexPath).row])
        // 셀의 이미지 뷰에 앞에서 선언한 itemsImageFile 배열을 대입

        return cell
    }
    // 셀과 레이블과 이미지에 앞에서 선언한 변수가 적용되도록 수정

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            items.remove(at: (indexPath as NSIndexPath).row)
            itemsImageFile.remove(at: (indexPath as NSIndexPath).row)
            tableView.deleteRows(at: [indexPath], with: .fade)      // 추가한거 열에 저장해서 삭제한다.
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    // 이 함수는 셀의 내용을 삭제하는 함수

    
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
        let itemToMove = items[(fromIndexPath as NSIndexPath).row]  // 이동할 아이템의 위치를 itemToMove에 저장
        let itemImageToMove = itemsImageFile[(fromIndexPath as NSIndexPath).row]    // 이동할 아이템의 이미지 위치를 저장
        items.remove(at: (fromIndexPath as NSIndexPath).row)    // 이동할 아이템을 삭제. 이때 삭제한 아이템 뒤의 아이템들의 인덱스가 재정렬
        itemsImageFile.remove(at: (fromIndexPath as NSIndexPath).row)   // 이동할 아이템 이미지 삭제
        items.insert(itemToMove, at: (to as NSIndexPath).row)   // 삭제된 아이템을 이동할 위치로 삽입 후 아이템들의 인덱스가 재정렬
        itemsImageFile.insert(itemImageToMove, at: (to as NSIndexPath).row) // 이미지 이동
    }
    // 목록 순서 바꿀수 있게 하는 함수

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        
        if segue.identifier == "sgDetail" {
            let cell = sender as! UITableViewCell
            let indexPath = self.tvListView.indexPath(for: cell)
            let detailView = segue.destination as! DetailViewController
            detailView.receiveItem(items[((indexPath as NSIndexPath?)?.row)!])
        }
        // 11장에서 세그웨이를 이용하여 뷰를 전환하는 것과 같은 방법을 사용. 다만 TableViewCell의 indexPath를 구하는 부분이 추가됨
    }
    // prepare 함수는 세그웨이를 이용하여 뷰를 이동하는 함수입니다.
}
