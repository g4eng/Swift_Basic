//
//  ViewController.swift
//  MoviePlayer
//
//  Created by G4ENG on 11/02/2019.
//  Copyright © 2019 YangGaeng. All rights reserved.
//

import UIKit
import AVKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func btnPlayInternalMovie(_ sender: UIButton) {
        let filePath: String? = Bundle.main.path(forResource: "FastTyping", ofType: "mp4")
        // 우선 비디오 파일명을 사용하여 비디오가 저장된 앱 내부의 파일 경로를 받아온다.
        let url = NSURL(fileURLWithPath: filePath!)
        // 앱 내부의 파일명을 NSURL 형식으로 변경
        
        playVideo(url: url)
        
        /*
         let playerController = AVPlayerViewController()
         //인스턴스 생성
         let player = AVPlayer(url: url as URL)  // 비디오URL로 초기환 AVPlayer의 인스턴스 생성
         playerController.player = player    // 컨트롤러의 플레이어 속성에 인스턴스 할당
         
         self.present(playerController, animated: true) {
         player.play()   // 비디오 재생
         }
         */
        

    }
    
    @IBAction func btnPlayInternalMov(_ sender: UIButton) {
        let filePath: String? = Bundle.main.path(forResource: "Mountaineering", ofType: "mov")
        
        let url = NSURL(fileURLWithPath: filePath!)
        
        playVideo(url: url)
    }
    
    // 외부 링크 비디오 재생
    @IBAction func btnPlayExternalMovie(_ sender: UIButton) {
        // 외부 파일 mp4
        let url = NSURL(string: "https://dl.dropboxusercontent.com/s/e38auz050w2mvud/Fireworks.mp4")!
        
        playVideo(url: url)
        
        
        /*
         let playerController = AVPlayerViewController()
         
         let player = AVPlayer(url: url as URL)
         playerController.player = player
         
         self.present(playerController, animated: true) {
         player.play()
         }
         */

    }
    
    @IBAction func btnPlayExtrnalMov(_ sender: UIButton) {
        let url = NSURL(string: "https://dl.dropboxusercontent.com/s/ijybpprsmx0bgre/Seascape.mov")!
        
        playVideo(url: url)
    }
    
    private func playVideo(url: NSURL) {
        let playerController = AVPlayerViewController()
        
        let player = AVPlayer(url: url as URL)
        playerController.player = player
        
        self.present(playerController, animated: true) {
            player.play()
        }
    }
}

