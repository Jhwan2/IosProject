//
//  ViewController.swift
//  MusicPlayer
//
//  Created by 이주환 on 2022/07/28.
//

import UIKit
import AVFoundation

class ViewController: UIViewController, AVAudioPlayerDelegate {
    
    var player: AVAudioPlayer!
    var timer: Timer!
    
    
    @IBOutlet var playPauseButton: UIButton!
    @IBOutlet var timeLabel: UILabel!
    @IBOutlet var progressSilder: UISlider!
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.initializePlayer()
    }
    // MARK: custom method
    func initializePlayer() {//초기화 함수
        
        guard let soundAsset: NSDataAsset = NSDataAsset(name: "sound") else{
            print("No sound file !!")
            return
        } // sound 파일을 불러오는과정
        // NSDataAsset < 아마 사운드 불러오는 과정에 사용되는 데이터 타입 ? 뭐지 ? 알아보고
        //이부분 guard 를 쓰는이유는 대강은 알겠지만 다시알아보기
        do{//do- try 와 catch이 부분 다시공부
            try self.player = AVAudioPlayer(data: soundAsset.data) //오디오 데이터 불러오기
            self.player.delegate = self //이거뭐지 ?
        } catch let error as NSError{ //에러 구문
            print("player init Fail !!")
            print("Coed : \(error.code), Messege : \(error.localizedDescription)")
        }
        self.progressSilder.maximumValue = Float(self.player.duration)
        self.progressSilder.minimumValue = 0
        self.progressSilder.value = Float(self.player.currentTime)// 이렇게 초기화하는 이유는 하면서 둘러보고 .
        
    }
    
    func updateTimeLabelText(time: TimeInterval){  // 시간실시간 업데이트및 텍스트 설정 ?
        let minute: Int = Int(time/60)
        let second: Int = Int(time.truncatingRemainder(dividingBy: 60))
        let milisecond: Int = Int(time.truncatingRemainder(dividingBy: 1)*100)
        //그냥 Time에 있는 시간 분, 초, 밀리초 나누어 주는건데 truncatingRemainder 정돈 알아두기
        let timeText: String = String(format: "%02ld:%02ld:%02ld", minute,second,milisecond)
        //그냥 텍스트형식 지정
        self.timeLabel.text = timeText //텍스트형식 출력
    }
    
    func makeAndFireTimer() {  // 타이머를 만들고 설정해줄 메소드
        self.timer = Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true, block: {[unowned self] (timer: Timer) in
            if self.progressSilder.isTracking {return}
            
            self.updateTimeLabelText(time: self.player.currentTime)
            self.progressSilder.value = Float(self.player.currentTime)
        })
        self.timer.fire()
        //이부분은 아에모르겟다 공부해야할듯 ..
    }
    
    func invalidateTimer() {//타이머 헤제 메소드
        self.timer.invalidate()
        self.timer = nil
    }
    
    func addViewsWithCode() { // 현재시점 미구현 method
        //self.addPlayPauseButton()
        //self.addTimeLabel()
        //self.addProgressSlider()
    }
    
    func addPlayPauseButton() { //이 부분 모르겟음 .. 공부해봐야해
        
        let button: UIButton = UIButton(type: UIButton.ButtonType.custom) //버튼 연결 ?
        button.translatesAutoresizingMaskIntoConstraints = false //여러기기에서의 사이즈 조정 ? 에관련인데 한번더 공부해보기
        
        self.view.addSubview(button)
        
        button.setImage(UIImage(named: "button_play"), for: UIControl.State.normal)
        button.setImage(UIImage(named: "button_pause"), for: UIControl.State.selected)//버튼 상태별 이미지 설정
        
        button.addTarget(self, action: #selector(self.touchUpPlayPauseButton(_:)), for: UIControl.Event.touchUpInside)//버튼 이벤트 발생시 액션 설정
        
        let centerX: NSLayoutConstraint
        centerX = button.centerXAnchor.constraint(equalTo: self.view.centerXAnchor)
        
        let centerY: NSLayoutConstraint
        centerY = NSLayoutConstraint(item: button, attribute: NSLayoutConstraint.Attribute.centerX, relatedBy: NSLayoutConstraint.Relation.equal, toItem: self.view, attribute: NSLayoutConstraint.Attribute.centerY, multiplier: 0.8, constant: 0) //이부분 뭐지 ?
        
        let width: NSLayoutConstraint
        width = button.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.5)
        
        let ratio: NSLayoutConstraint
        ratio = button.heightAnchor.constraint(equalTo: button.widthAnchor, multiplier: 1)
        
        centerX.isActive = true
        centerY.isActive = true
        width.isActive = true
        ratio.isActive = true
        
        self.playPauseButton = button
    }
    
    func addTimeLabel() {
        let timeLabel: UILabel = UILabel()
        timeLabel.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(timeLabel)
        
        timeLabel.textColor = UIColor.black
        timeLabel.textAlignment = NSTextAlignment.center
        timeLabel.font = UIFont.preferredFont(forTextStyle: UIFont.TextStyle.headline)
        
        let centerX: NSLayoutConstraint
        centerX = timeLabel.centerXAnchor.constraint(equalTo: self.playPauseButton.centerXAnchor)
        
        let top: NSLayoutConstraint
        top = timeLabel.topAnchor.constraint(equalTo: self.playPauseButton.bottomAnchor, constant: 8)
        
        centerX.isActive = true
        top.isActive = true
        
        self.timeLabel = timeLabel
        self.updateTimeLabelText(time: 0)
    }
    
    func addProgressSlider() {
        let slider: UISlider = UISlider()
        slider.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(slider)
        
        slider.minimumTrackTintColor = UIColor.red
        
        slider.addTarget(self, action: #selector(self.sliderValueChange(_:)), for: UIControl.Event.valueChanged)
        
        let safeAreaGuide: UILayoutGuide = self.view.safeAreaLayoutGuide
        
        let centerX: NSLayoutConstraint
        centerX = slider.centerXAnchor.constraint(equalTo: self.timeLabel.centerXAnchor)
        
        let top: NSLayoutConstraint
        top = slider.topAnchor.constraint(equalTo: self.timeLabel.bottomAnchor, constant: 8)
        
        let leading: NSLayoutConstraint
        leading = slider.leadingAnchor.constraint(equalTo: safeAreaGuide.leadingAnchor, constant: 16)
        
        let trailing: NSLayoutConstraint
        trailing = slider.trailingAnchor.constraint(equalTo: safeAreaGuide.trailingAnchor, constant: -16)
        
        centerX.isActive = true
        top.isActive = true
        leading.isActive = true
        trailing.isActive = true
        
        self.progressSilder = slider
    }
    
    
    @IBAction func touchUpPlayPauseButton(_ sender: UIButton) {
        
        sender.isSelected = !sender.isSelected
        
        if sender.isSelected {
            self.player?.play()
        } else {
            self.player?.pause()
        }
        
        if sender.isSelected {
            self.makeAndFireTimer()
        } else {
            self.invalidateTimer()
        }
    }
    
    
    //@IBAction func playerButton(_ sender: UIButton) {
    //    print("action !! ")
    //}

    @IBAction func sliderValueChange(_ sender: UISlider) {
        self.updateTimeLabelText(time: TimeInterval(sender.value))
        if sender.isTracking { return }
        self.player.currentTime = TimeInterval(sender.value)
    }
    func audioPlayerDecodeErrorDidOccur(_ player: AVAudioPlayer, error: Error?) {
        
        guard let error: Error = error else {
            print("오디오 플레이어 디코드 오류발생")
            return
        }
        
        let message: String
        message = "오디오 플레이어 오류 발생 \(error.localizedDescription)"
        
        let alert: UIAlertController = UIAlertController(title: "알림", message: message, preferredStyle: UIAlertController.Style.alert)
        
        let okAction: UIAlertAction = UIAlertAction(title: "확인", style: UIAlertAction.Style.default) { (action: UIAlertAction) -> Void in
            
            self.dismiss(animated: true, completion: nil)
        }
        
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
    }
    
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        self.playPauseButton.isSelected = false
        self.progressSilder.value = 0
        self.updateTimeLabelText(time: 0)
        self.invalidateTimer()
    }
    
}

