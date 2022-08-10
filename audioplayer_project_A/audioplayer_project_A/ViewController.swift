//
//  ViewController.swift
//  audioplayer_project_A
//
//  Created by 이주환 on 2022/07/31.
//

import UIKit
import AVFoundation

class ViewController: UIViewController, AVAudioPlayerDelegate {
    
    var timer: Timer!
    var player: AVAudioPlayer!
    
    @IBOutlet var playerButton: UIButton!
    @IBOutlet var slider: UISlider!
    @IBOutlet var timelable: UILabel!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.initPlayer()
    }
    
    //MARK: init Method
    func initPlayer(){
        
        guard let soundAsset: NSDataAsset = NSDataAsset(name: "sound") else {
            print("sound File load Fail !")
            return
        }
        
        do {
        try self.player = AVAudioPlayer(data: soundAsset.data)
            self.player.delegate = self}
        catch let error as NSError {
            print("플레이어 초기화 실패")
            print("코드 : \(error.code), 메세지 : \(error.localizedDescription)")
        }//플레이어 초기화
        
        self.slider.minimumValue = 0
        self.slider.maximumValue = Float(player.duration)
        self.slider.value = Float(player.currentTime)
        self.timelable.text = String("00:00:00")
    }
    
    //MARK: progree Method
    func TextUpdate(time: TimeInterval) {
        let m: Int = Int(time/60)
        let s: Int = Int(time.truncatingRemainder(dividingBy: 60))
        let mil: Int = Int(time.truncatingRemainder(dividingBy: 1)*100)
        
        let hi: String = String(format: "%02ld:%02ld:%02ld", m,s,mil)
        
        self.timelable.text = hi
    }
    
    func TimerSetting(){
        self.timer = Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true, block: { Timer in
            if self.slider.isTracking { return }
            self.TextUpdate(time: self.player.currentTime)
            self.slider.value = Float(self.player.currentTime)
        })
    }
    func TimerInit() {
        self.timer.invalidate()
        self.timer = nil
    }
    
    
    
    
    
    
    
    //MARK: Action Method
    @IBAction func Play_Song(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        
        if sender.isSelected {
            self.player.play()
            self.TimerSetting()
        }
        else{
            self.player.pause()
            self.TimerInit()
        }
    }
    
    @IBAction func ChangedValue(_ sender: UISlider) {
        //슬라이더값 => 플래이값
        if sender.isTracking {return}
        TextUpdate(time: TimeInterval(sender.value))
        self.player.currentTime = TimeInterval(sender.value)
    }
    
    
    func audioPlayerDidFinishPlaying(
        _ player: AVAudioPlayer,
        successfully flag: Bool
    ){
        self.TextUpdate(time: TimeInterval(0))
        self.playerButton.isSelected = false
        self.slider.value = 0
        self.TimerInit()
    }
    


}

