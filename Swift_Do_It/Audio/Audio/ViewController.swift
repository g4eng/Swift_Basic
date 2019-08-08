//
//  ViewController.swift
//  Audio
//
//  Created by G4ENG on 10/02/2019.
//  Copyright © 2019 YangGaeng. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController, AVAudioPlayerDelegate, AVAudioRecorderDelegate {

    var audioPlayer : AVAudioPlayer!    // 인스턴스 변수
    var audioFile: URL!     // 재생할 오디오의 파일명 변수
    let MAX_VOLUME: Float = 10.0    // 최대 볼륨, 실수형 상수
    var progressTimer: Timer!   // 타이머를 위한 변수
    
    let timePlayerSelector: Selector = #selector(ViewController.updatePlayTime)
    let timeRecrodSelector: Selector = #selector(ViewController.updateRecordTime)

    // 녹음 기능 변수
    var audioRecorder: AVAudioRecorder!
    var isRecordMode = false    // 녹음모드 온오프 변수
    
    var imgPlay = UIImage(named: "play.png")
    var imgPause = UIImage(named: "pause.png")
    var imgStop = UIImage(named: "stop.png")
    var imgRecord = UIImage(named: "record.png")
    
    @IBOutlet var pvProgressPlay: UIProgressView!
    @IBOutlet var lblCurrentTime: UILabel!
    @IBOutlet var lblEndTime: UILabel!
    @IBOutlet var btnPlay: UIButton!
    @IBOutlet var btnPause: UIButton!
    @IBOutlet var btnStop: UIButton!
    @IBOutlet var slVolume: UISlider!
    @IBOutlet var btnRecord: UIButton!
    @IBOutlet var lblRecordTime: UILabel!
    @IBOutlet var stateImg: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        // audioFile = Bundle.main.url(forResource: "Sicilian_Breeze", withExtension: "mp3")
        // 윗줄은 selectAudioFile() 함수로 옮겨준다.
        selectAudioFile()
        if !isRecordMode {  // 재생모드일때는 녹음 버튼, 녹음시간 enable시킴
            initPlay()
            btnRecord.isEnabled = false
            lblRecordTime.isEnabled = false
        }
        else {
            initRecord()
        }
        
        stateImg.image = imgStop
    }
    
    func selectAudioFile() {
        if !isRecordMode {
            audioFile = Bundle.main.url(forResource: "Sicilian_Breeze", withExtension: "mp3")
        }
        else {
            let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
            audioFile = documentDirectory.appendingPathComponent("recordFile.m4a")
            // 녹음 모드일 때는 새 파일 생성
        }
    }
    
    // 오디오 재생을 위한 초기화
    func initPlay() {
        do {    // try 오류 발생 가능 함수 호출
            audioPlayer = try AVAudioPlayer(contentsOf: audioFile)
        }
        catch let error as NSError {    // 오류 타입에 대한 처리 구문
            print("Error-initPlay :  \(error)")
        }
        
        slVolume.maximumValue = MAX_VOLUME
        slVolume.value = 1.0
        pvProgressPlay.progress = 0
        
        audioPlayer.delegate = self     // 델리게이트 셀프 설정
        audioPlayer.prepareToPlay()     // 플래이할 준비하는 함수
        audioPlayer.volume = slVolume.value
        
        lblEndTime.text = convertNSTimeInterval2String(audioPlayer.duration)
        // 오디오 파일의 재생 시간인 audioPlayer.duaration 값을 함수를 이용해 end에 출력
        lblCurrentTime.text = convertNSTimeInterval2String(0)
        // 함수를 이용해 00:00이 출력 되도록 0 값을 입력

        /*
        btnPlay.isEnabled = true
        btnPause.isEnabled = true
        btnStop.isEnabled = true
        */
        
        setPlayButtons(true, pause: false, stop: false)
    }
    
    func initRecord() {
        let recordSetting = [AVFormatIDKey: NSNumber(value: kAudioFormatAppleLossless as UInt32), AVEncoderAudioQualityKey: AVAudioQuality.max.rawValue, AVEncoderBitRateKey: 32000, AVNumberOfChannelsKey: 2, AVSampleRateKey: 44100.0] as [String: Any]
        // 포맷 apple Lossless, 음질은 최대, 비트율: 32000, 2채널, 샘플률은 441000
        do {
            audioRecorder = try AVAudioRecorder(url: audioFile, settings: recordSetting)
        }
        catch let error as NSError {
            print("Error-initRecord : \(error)")
        }
        
        audioRecorder.delegate = self     // 레코더 델리게이트를 self로 설정
        audioRecorder.isMeteringEnabled = true      // 박자 관련 isMeteringEnabled 값을 true
        audioRecorder.prepareToRecord() //  녹음 준비 함수 실행
        
        slVolume.value = 1.0
        audioPlayer.volume = slVolume.value
        lblEndTime.text = convertNSTimeInterval2String(0)
        lblCurrentTime.text = convertNSTimeInterval2String(0)
        setPlayButtons(false, pause: false, stop: false)
        
        // 에러를 없애기 위해 AVAudioSession의 인스턴스 세션을 생성하고 try-catch문을 사용해 카테고리를 설정한 다음 액티브 설정
        let session = AVAudioSession.sharedInstance()
        do {
            try session.setCategory(AVAudioSession.Category.playAndRecord, mode: .default, options: .allowBluetooth)
        }
        catch let error as NSError {
            print("Error-initRecord : \(error)")
        }
        
        do {
            try session.setActive(true)
        }
        catch let error as NSError {
            print("Error-setActive : \(error)")
        }
        
    }
    
    func setPlayButtons(_ play: Bool, pause: Bool, stop: Bool) {
        btnPlay.isEnabled = play
        btnPause.isEnabled = pause
        btnStop.isEnabled = stop
    }
    
    func convertNSTimeInterval2String(_ time: TimeInterval) -> String {
        let min = Int(time/60)
        // 매개변수 60으로 나눈 몫을 정수값으로 변환하여 분으로
        let sec = Int(time.truncatingRemainder(dividingBy: 60))
        // 나머지 값을 정수로 변환하여 초로
        let strTime = String(format: "%02d:%02d",min,sec)
        // 포맷 변경
        return strTime
    }
    
    @objc func updatePlayTime() {
        lblCurrentTime.text = convertNSTimeInterval2String(audioPlayer.currentTime)
        // 재생시간인 audioPlayer.currentTime 전달
        pvProgressPlay.progress = Float(audioPlayer.currentTime/audioPlayer.duration)
    }

    @IBAction func btnPlayAudio(_ sender: UIButton) {
        audioPlayer.play()
        setPlayButtons(false, pause: true, stop: true)
        progressTimer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: timePlayerSelector, userInfo: nil, repeats: true)
        stateImg.image = imgPlay
    }
    
    @IBAction func btnPauseAudio(_ sender: UIButton) {
        audioPlayer.pause()
        setPlayButtons(true, pause: false, stop: true)
        stateImg.image = imgPause
    }
    
    @IBAction func btnStopAudio(_ sender: UIButton) {
        audioPlayer.stop()
        audioPlayer.currentTime = 0
        lblCurrentTime.text = convertNSTimeInterval2String(0)       // 0으로 초기화
        setPlayButtons(true, pause: false, stop: false)
        progressTimer.invalidate()      // 타이머도 무효화
        stateImg.image = imgStop
    }
    
    @IBAction func slChangeVolume(_ sender: UISlider) {
        audioPlayer.volume = slVolume.value
    }
    
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        progressTimer.invalidate()
        setPlayButtons(true, pause: false, stop: false)
        stateImg.image = imgStop
    }
    
    @IBAction func swRecordMode(_ sender: UISwitch) {
        if sender.isOn {
            audioPlayer.stop()
            audioPlayer.currentTime = 0
            lblRecordTime!.text = convertNSTimeInterval2String(0)
            isRecordMode = true
            btnRecord.isEnabled = true
            lblRecordTime.isEnabled = true
        }
        else {
            isRecordMode = false
            btnRecord.isEnabled = false
            lblRecordTime.isEnabled = false
            lblRecordTime.text = convertNSTimeInterval2String(0)
        }
        
        selectAudioFile()
        if !isRecordMode {  // 재생모드일때
            initPlay()
        }
        else {              // 녹음 모드
            initRecord()
        }
    }
    
    @IBAction func btnRecord(_ sender: UIButton) {
        if sender.titleLabel?.text == "Record" {    // 버튼 이름이 레코드면 녹음하고 버튼이름을 스탑으로 변경
            audioRecorder.record()
            sender.setTitle("Stop", for: UIControl.State())
            progressTimer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: timeRecrodSelector, userInfo: nil, repeats: true)
            stateImg.image = imgRecord
        }
        else {      // 녹음 중단하고 버튼이름을 스탑으로 변경하고 플레이버튼 활성화, 방금 녹음한 파일로 재생을 초기화
            audioRecorder.stop()
            sender.setTitle("Record", for: UIControl.State())
            btnPlay.isEnabled = true
            initPlay()
            stateImg.image = imgStop
        }
    }
    
    @objc func updateRecordTime(){
        lblRecordTime.text = convertNSTimeInterval2String(audioRecorder.currentTime)
    }
}

