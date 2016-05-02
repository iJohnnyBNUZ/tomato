//
//  Home.swift
//  Tomato
//
//  Created by Johnny on 16/4/15.
//  Copyright © 2016年 Johnny. All rights reserved.
//

import UIKit
//import AVFoundation

class Home: UIViewController {

    @IBOutlet weak var clearButton: UIButton!
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var timeLabel: UILabel!
    
    var isPlaying = false
    var soundPlayer:AVAudioPlayer?
    
    var remianingSeconds: Int = 0 {
        willSet(newSeconds) {
            let mins = newSeconds/60
            let seconds = newSeconds%60
            timeLabel!.text = NSString(format: "%02d:%02d", mins, seconds) as String
        }
    }
    var isCounting: Bool = false {
        willSet(newValue) {
            if newValue {
                timer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: "updateTimer:", userInfo: nil, repeats: true)
            } else {
                timer?.invalidate()
                timer = nil
            }
            setSettingButtonsEnabled(!newValue)
        }
    }
    var timer:NSTimer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        remianingSeconds = 1500
        // Do any additional setup after loading the view.
    }
    
    func updateTimer(timer: NSTimer) {
        remianingSeconds -= 1
        
        if remianingSeconds <= 0 {
            
            self.isCounting = false
            self.timeLabel?.text = "25:00"
            self.remianingSeconds = 1500
            
            let alert = UIAlertView()
            alert.title = "计时完成！"
            alert.message = ""
            alert.addButtonWithTitle("OK")
            alert.show()
            
        }
    }
    func setSettingButtonsEnabled(enabled: Bool) {
        startButton!.enabled = enabled
        startButton!.alpha = enabled ? 1.0 : 0.3
    }
    
    @IBAction func startButton(sender: AnyObject) {
        //playSound(0)
        isCounting = !isCounting
    }
    @IBAction func clearButton(sender: AnyObject) {
        remianingSeconds = 1500
        //remianingSeconds = 5
        isCounting = false
    }
    
//    func playSound(soundIndex: Int) {
//        let startSoundPath = NSBundle.mainBundle().pathForResource("Start", ofType: "mp3")
//        let stopSoundPath = NSBundle.mainBundle().pathForResource("Stop", ofType: "mp3")
//        let pomoingSoundPath = NSBundle.mainBundle().pathForResource("Pomoing", ofType: "mp3")
//        
//        let startSoundUrl = NSURL(fileURLWithPath: startSoundPath!)
//        let stopSoundUrl = NSURL(fileURLWithPath: stopSoundPath!)
//        let pomoingSoundUrl = NSURL(fileURLWithPath: pomoingSoundPath!)
//        
//        switch soundIndex {
//        case 0:
//            stopSound()
//            //if enableAlarmSound {
//                do {soundPlayer = try AVAudioPlayer(contentsOfURL: stopSoundUrl)} catch _ { }
//                soundPlayer!.numberOfLoops = 0
//                soundPlayer!.volume = 1
//                soundPlayer!.prepareToPlay()
//                soundPlayer!.play()
//            //}
//        case 1:
//            stopSound()
//           // if enableAlarmSound {
//                do {soundPlayer = try AVAudioPlayer(contentsOfURL: startSoundUrl)} catch _ { }
//                soundPlayer!.numberOfLoops = -1
//                soundPlayer!.volume = 1
//                soundPlayer!.prepareToPlay()
//                soundPlayer!.play()
//            //}
//        case 2:
//            stopSound()
//            //if enableTimerSound {
//                do {soundPlayer = try AVAudioPlayer(contentsOfURL: pomoingSoundUrl)} catch _ { }
//                soundPlayer!.numberOfLoops = -1
//                soundPlayer!.volume = 0.2
//                soundPlayer!.prepareToPlay()
//                soundPlayer!.play()
//            //}
//            
//        default:
//            if soundPlayer != nil {
//                soundPlayer!.stop()
//            }
//        }
//    }
//    func stopSound() {
//        if soundPlayer != nil {
//            soundPlayer!.stop()
//        }
//    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
