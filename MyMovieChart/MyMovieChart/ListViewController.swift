//
//  ListViewController.swift
//  MyMovieChart
//
//  Created by G4ENG on 24/07/2019.
//  Copyright © 2019 G4ENG. All rights reserved.
//

import UIKit

class ListViewController: UITableViewController {
    /*
    // 테이블 뷰를 구성할 리스트 데이터
    var list = [MovieVO]()
    
    override func viewDidLoad() {
        // 첫번째 행
        var mvo = MovieVO()
        mvo.title = "Dark Knight"
        mvo.description = "영웅물에 철학에 음악가지 더해져 예술이 되다"
        mvo.opendate = "2008-09-04"
        mvo.rating = 8.95
        // 배열에 추가
        self.list.append(mvo)
        
        // 두번째 행
        mvo = MovieVO()
        mvo.title = "호우시절"
        mvo.description = "때를 알고 내리는 좋은 비"
        mvo.opendate = "2009-10-08"
        mvo.rating = 7.31
        // 배열에 추가
        self.list.append(mvo)
        
        // 세번째 행
        mvo = MovieVO()
        mvo.title = "말할 수 없는 비밀"
        mvo.description = "여기서 너까지 다섯 걸음"
        mvo.opendate = "2015-05-07"
        mvo.rating = 9.19
        // 배열에 추가
        self.list.append(mvo)
 */
    /*
    // 튜플 아이템으로 구성된 데이터 세트
    var dateset = [
    ("다크 나이트","영웅물에 철학에 음악까지 더해져 예술이 되다","2008-09-04",8.95,"darknight.jpg"),
    ("호우시절","때를 알고 내리는 좋은 비","2009-10-08",7.31,"rain.jpg"),
    ("말할 수 없는 비밀", "여기서 너까지 다섯 걸음","2015-05-07",9.19,"secret.jpg")
    ]
    */
    // 테이블 뷰를 구성할 리스트 데이터
    lazy var list: [MovieVO] = {
        var datalist = [MovieVO]()
        /*
        for (title, desc, opendate, rating, thumbnail) in self.dateset {
            let mvo = MovieVO()
            mvo.title = title
            mvo.description = desc
            mvo.opendate = opendate
            mvo.rating = rating
            mvo.thumbnail = thumbnail
            
            datalist.append(mvo)
        }
        */
        return datalist
    }()
    
    // 현재까지 읽어온 데이터의 페이지 정보
    var page = 1
    
    func callMovieAPI() {
        // 1. 호핀 api 호출을 위한 URI 생성
        let url = "http://swiftapi.rubypaper.co.kr:2029/hoppin/movies?version=1&page=\(self.page)&count=30&genreId=&order=releasedateasc"
        let apiURI: URL! = URL(string: url)
        
        // 2. rest api 호출
        let apidata = try! Data(contentsOf: apiURI)
        
        // 3. 데이터 전송 결과를 로그로 출력 ( 반드시 필요한 코드는 아님 )
        let log = NSString(data: apidata, encoding: String.Encoding.utf8.rawValue) ?? ""
        NSLog("API Result = \(log)")
        
        // 4. JSON 객체를 파싱하여 NSDictionary 객체로 받음
        do {
            let apiDictionary = try JSONSerialization.jsonObject(with: apidata, options: []) as! NSDictionary
            
            // 5. 데이터 구조에 따라 차례대로 캐스팅하며 읽어온다.
            let hoppin = apiDictionary["hoppin"] as! NSDictionary
            let movies = hoppin["movies"] as! NSDictionary
            let movie = movies["movie"] as! NSArray
            
            // 6. Iterator 처리를 하면서 API 데이터를 MovieVO 객체에 저장
            for row in movie {
                // 순회 상수를 NSDictionary 타입으로 캐스팅
                let r = row as! NSDictionary
                
                // 테이블 뷰 리스트를 구성할 데이터 형식
                let mvo = MovieVO()
                
                // movie 배열에 각 데이터를 mvo 상수의 속성에 대입
                mvo.title = r["title"] as? String
                mvo.description = r["genreNames"] as? String
                mvo.thumbnail = r["thumbnailImage"] as? String
                mvo.detail = r["linkUrl"] as? String
                mvo.rating = ((r["ratingAverage"] as! NSString).doubleValue)
                
                // <- 추가되는 코드 시작
                // 웹상에 있는 이미지를 읽어와 UIImage 객체로 저장
                let url: URL! = URL(string: mvo.thumbnail!)
                let imageData = try! Data(contentsOf: url)
                mvo.thumbnailImage = UIImage(data: imageData)
                
                // list 배열에 추가
                self.list.append(mvo)
                
                // 7. 전체 데이터 카운트를 얻는ㄷㅏ
                let totalCount = (hoppin["totalCount"] as? NSString)!.integerValue
                
                // 8. totalCount가 읽어온 데이터 크기와 같거나 클 경우 더보기 버튼을 막는다
                if (self.list.count >= totalCount) {
                   // self.moreBtn.isHidden = true
                    self.moreBtn.isEnabled = false
                    self.moreBtn.setTitle("마지막 목록입니다", for: .disabled)
                }
            }
        }
        catch {
            NSLog("Parse Error")
        }
    }
    
    func getThumbnailImage(_ index: Int) -> UIImage {
        // 인자값으로 받은 인덱스를 기반으로 해당하는 배열 데이터를 읽어옴
        let mvo = self.list[index]
        
        // 메모이제이션: 저장된 이미지가 있으면 그것을 반환하고, 없으면 내려 받아서 저장한 후 반환
        if let savedImage = mvo.thumbnailImage {
            return savedImage
        }
        else {
            let url: URL! = URL(string: mvo.thumbnail!)
            let imageData = try! Data(contentsOf: url)
            mvo.thumbnailImage = UIImage(data: imageData) // uiimage를 MovieVO 객체에 우선 저장
            
            return mvo.thumbnailImage!  // 저장된 이미지 반환
        }
    }
    
    override func viewDidLoad() {
        // callMovieAPI 호출
        self.callMovieAPI()
    }
    
    @IBOutlet var moreBtn: UIButton!

    @IBAction func more(_ sender: Any) {
        // 0. 현재 페이지 값에 1 추가
        self.page += 1
        print(self.page)
        self.callMovieAPI()
        
        // 테이블 뷰 갱신
        self.tableView.reloadData()
    }
    
    
    // 테이블 뷰 행의 개수를 반환하는 메소드
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.list.count
    }
    // 이 메소드는 생성해야 할 행의 개수를 반환하는 메소드, 이 메소드가 반환하는 값만큼의 테이블 뷰 행을 생성. 메소드 호출 시 함께 전달되는 두 개의 매개변수 tableView와 section은 각각 어느 테이블 뷰인지, 그리고 테이블 뷰 내에세도 몇 번째 섹션에 대한 호출이닞 알려준다.
    
    // 개별 행을 만들어내는 역할. 메소드가 반환하는 값만큼 이 메소드가 반복 호출됨. 메소드가 한 번 호출될 때마다 하나의 행이 만들어진다고 생각하면 된다.
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // 주어진 행에 맞는 데이터 소스를 읽어온다
        let row = self.list[indexPath.row]
        // 테이블 셀 객체를 직접 생성하는 대신 큐로부터 가져옴
        
        // 로그 출력
        NSLog("제목: \(row.title!), 호출된 행번호: \(indexPath.row)")
        
        // ~! -> as! MovieCell로 변경
        let cell = tableView.dequeueReusableCell(withIdentifier: "ListCell") as! MovieCell
        
        /*
        cell.textLabel?.text = row.title
        
        // 추가사항 : 섭타이틀에 데이터 연결
        cell.detailTextLabel?.text = row.description
        */
        
        /*
        // ---> 추가되는 부분 시작
        // 영화 제목이 표시될 레이블을 title 변수로 받음
        let title = cell.viewWithTag(101) as? UILabel
        // 요약 desc
        let desc = cell.viewWithTag(102) as? UILabel
        // 개봉일 opendate
        let opendate = cell.viewWithTag(103) as? UILabel
        // 별점 rating
        let rating = cell.viewWithTag(104) as? UILabel
        // 데이터 소스에 저장된 값을 각 레이블 변수에 할당
        title?.text = row.title
        desc?.text = row.description
        opendate?.text = row.opendate
        rating?.text = "\(row.rating!)"
        // <--- 끝
        */
        
        // 데이터 소스에 저장된 값을 각 아울렛 변수에 할당
        cell.title?.text = row.title
        cell.desc?.text = row.description
        cell.opendate?.text = row.opendate
        cell.rating?.text = "\(row.rating!)"
        
        /*
        // 섬네일 경로 URL 객체 생성
        let url: URL! = URL(string: row.thumbnail!)
        // 이미지를 읽어와 Data 객체에 저장
        let imageData = try! Data(contentsOf: url)
        // UIImage 개체를 생성하여 아울렛 변수의 image 속성에 대입
        cell.thumbnail?.image = UIImage(data: imageData)
        */
        
        // 이미지 객체를 대입
        // cell.thumbnail.image = row.thumbnailImage
        
        // 수정) 비동기 방식으로 섬네일 이미지를 읽어옴
        DispatchQueue.main.async(execute: {
            cell.thumbnail.image = self.getThumbnailImage(indexPath.row)
        })
        return cell
    }
    
    // 테이블 셀을 클릭하거나 터치했을 때 액션을 처리해주려면 이 메소드를 구현
    // 사용자가 셀을 선택하면 델리게이트 시스템에 의해 이 메소드가 호출되기 때문.
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        NSLog("선택된 행은 \(indexPath.row+1)번째 행이다")
    }
}

// MARK: - 화면 전환 시 값을 넘겨주기 위한 세그웨이 관련 처리
extension ListViewController {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // 실행된 세그웨이 식별자가 segue_detail이면
        if segue.identifier == "segue_detail" {
            /* 축약한거
            // 사용자가 클릭한 행을 찾아낸다
            let path = self.tableView.indexPath(for: sender as! MovieCell)
            
            // 행 정보를 통해 선택된 영화 데이터를 찾은 다음, 목적비 뷰 컨트롤러의 mvo 변수에 대입한다.
            let detailVC = segue.destination as? DetailViewController
            detailVC?.mvo = self.list[path!.row]
            */
            
            // sender 인자를 캐스팅하여 테이블 셀 객체로 변환
            let cell = sender as! MovieCell
            
            // 사용자가 클릭한 행을 찾아낸다
            let path = self.tableView.indexPath(for: cell)
            
            // API 영화 데이터 배열 중에서 선택된 행에 대한 데이터 추출
            let movieInfo = self.list[path!.row]
            
            // 행 정보를 통해 선택된 영화 데이터를 찾은 다음, 목적지 뷰 컨트롤러의 mvo 변수에 대입
            let detailVC = segue.destination as? DetailViewController
            detailVC?.mvo = movieInfo
        }
    }
}
