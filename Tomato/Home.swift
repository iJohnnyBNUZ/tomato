//
//  Home.swift
//  Tomato
//
//  Created by Johnny on 16/4/15.
//  Copyright © 2016年 Johnny. All rights reserved.
//

import UIKit
import AVFoundation

class Home: UIViewController {

    
    @IBOutlet weak var clearButton: UIButton!
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var timeLabel: UILabel!
    
    var isPlaying = false
    var soundPlayer:AVAudioPlayer?
    var progress: KDCircularProgress!  //申明一个环
    var isRelax = false
    
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
            setButtonsEnabled(!newValue)
        }
    }
    var timer:NSTimer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        remianingSeconds = 1500
        setButtonsEnabled(true)
        //初始化环      
        progress = KDCircularProgress(frame: CGRect(x: 0, y: 0, width: 400, height: 400))
        progress.startAngle = -90
        progress.progressThickness = 0.1
        progress.trackThickness = 0.1
        progress.clockwise = true
        progress.gradientRotateSpeed = 2
        progress.roundedCorners = false
        progress.glowMode = .Forward
        progress.glowAmount = 0.9
        progress.trackColor = UIColor.whiteColor()
        //progress.setColors(UIColor.cyanColor() ,UIColor.whiteColor(), UIColor.magentaColor(), UIColor.whiteColor(), UIColor.orangeColor())
        progress.setColors(UIColor(red: 238.0/255.0, green:238.0/255.0, blue:0.0/255.0, alpha: 1.0))
        progress.center = CGPoint(x: view.center.x, y: timeLabel.center.y + 40 )
        view.addSubview(progress)
        // Do any additional setup after loading the view.
    }
    
    func updateTimer(timer: NSTimer) {

        remianingSeconds -= 1
        
        if remianingSeconds <= 0 {
            
            self.isCounting = false
            self.timeLabel?.text = "25:00"
            self.remianingSeconds = 1500
            
            let alert = UIAlertView()
            //setStopButtonsEnabled(true)
            alert.title = "计时完成！"
            alert.message = ""
            alert.addButtonWithTitle("OK")
            alert.show()
            
        }
    }
    //开始按钮隐藏
    func setButtonsEnabled(enabled: Bool) {
        startButton!.alpha = enabled ? 1.0 : 0.3
        startButton!.alpha = enabled ? 1.0 : 0.3
        startButton!.hidden = !enabled
        clearButton!.hidden = enabled
        startButton!.enabled = enabled
        clearButton!.enabled = !enabled
    }
    
//    @IBAction func longPress(sender: AnyObject) {
//        if sender.state == UIGestureRecognizerState.Ended {
//            print("UIGesture over")
//            pomodoroClass.playSound(5)
//            if process < 100 {
//                stopTimer()
//                processToZero()
//            } else {
//                pomodoroClass.start()
//                print("Pomodoro Started")
//                stopTimer()
//                timer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: "pomoing:", userInfo: nil, repeats: true)
//            }
//        } 
//         if sender.state == UIGestureRecognizerState.Began {
//                print("UIGesture start")
//                progress.animateFromAngle(0, toAngle: 360, duration: 1) { completed in
//                    if completed {
//                        print("animation stopped, completed")
//                        self.progress.angle = 0.0
//                    } else {
//                        print("animation stopped, was interrupted")
//                    }
//                }
//            
//                playSound(1)
//                isCounting = !isCounting
//                playSound(2)
//                progress.animateFromAngle(0, toAngle: 360, duration: 1500) { completed in
//                if completed {
//                    print("animation stopped, completed")
//                    self.progress.angle = 0.0
//                } else {
//                    print("animation stopped, was interrupted")
//                }
//            }
//        }
//    }
    
    @IBAction func startButton(sender: AnyObject) {
        playSound(1)
        isCounting = !isCounting
        
        playSound(2)
        progress.animateFromAngle(0, toAngle: 360, duration: 1500) { completed in
            if completed {
                print("animation stopped, completed")
            self.progress.angle = 0.0
            } else {
                print("animation stopped, was interrupted")
            }
        }
    }
    @IBAction func clearButton(sender: AnyObject) {
        playSound(0)
        remianingSeconds = 1500
        //remianingSeconds = 5
        self.progress.angle = 0.0
        self.progress.angle = 0.0
        isCounting = false
    }
    
    func playSound(soundIndex: Int) {
        let startSoundPath = NSBundle.mainBundle().pathForResource("Start", ofType: "mp3")
        let stopSoundPath = NSBundle.mainBundle().pathForResource("Stop", ofType: "mp3")
        let pomoingSoundPath = NSBundle.mainBundle().pathForResource("Pomoing", ofType: "mp3")
        
        let startSoundUrl = NSURL(fileURLWithPath: startSoundPath!)
        let stopSoundUrl = NSURL(fileURLWithPath: stopSoundPath!)
        let pomoingSoundUrl = NSURL(fileURLWithPath: pomoingSoundPath!)
        
        switch soundIndex {
        case 0:
            stopSound()
            //if enableAlarmSound {
                do {soundPlayer = try AVAudioPlayer(contentsOfURL: stopSoundUrl)} catch _ { }
                soundPlayer!.numberOfLoops = 0
                soundPlayer!.volume = 1
                soundPlayer!.prepareToPlay()
                soundPlayer!.play()
            //}
        case 1:
            stopSound()
           // if enableAlarmSound {
                do {soundPlayer = try AVAudioPlayer(contentsOfURL: startSoundUrl)} catch _ { }
                soundPlayer!.numberOfLoops = 0
                soundPlayer!.volume = 1
                soundPlayer!.prepareToPlay()
                soundPlayer!.play()
            //}
        case 2:
            stopSound()
            //if enableTimerSound {
                do {soundPlayer = try AVAudioPlayer(contentsOfURL: pomoingSoundUrl)} catch _ { }
                soundPlayer!.numberOfLoops = -1
                soundPlayer!.volume = 0.2
                soundPlayer!.prepareToPlay()
                soundPlayer!.play()
            //}
            
        default:
            if soundPlayer != nil {
                soundPlayer!.stop()
            }
        }
    }
    func stopSound() {
        if soundPlayer != nil {
            soundPlayer!.stop()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
