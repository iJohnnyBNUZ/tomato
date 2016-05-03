//
//  voiceChooseTbl.swift
//  Tomato
//
//  Created by Ponta on 16/4/22.
//  Copyright © 2016年 Johnny. All rights reserved.
//

import UIKit
import AVFoundation
import AudioToolbox

class voiceChooseTbl: UITableViewController {

    var isPlaying = false
    var soundPlayer:AVAudioPlayer?
    
   
    var voice = ["雷达(默认)","波浪","灯塔","顶峰","辐射","海边","欢乐时光","缓慢上升","急板","煎茶","举起","开场","流水","猫头鹰","山顶","闪烁","水晶","丝绸","往复"]
    var lastSelectedIndexPath: NSIndexPath? = nil
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return voice.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell:UITableViewCell = tableView.dequeueReusableCellWithIdentifier("voicechoose")!
        
        if indexPath.row == 0  {
            if lastSelectedIndexPath == nil{
                cell.accessoryType = .Checkmark
            }
            else if lastSelectedIndexPath != 0{
                cell.accessoryType = .None

            }
        }
        else{
            cell.accessoryType = (lastSelectedIndexPath?.row == indexPath.row) ? .Checkmark : .None
        }
        
        cell.textLabel!.text = voice[indexPath.row]
        
        // Configure the cell...
        
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        if indexPath.row != lastSelectedIndexPath?.row {
            if let lastSelectedIndexPath = lastSelectedIndexPath {
                let oldCell = tableView.cellForRowAtIndexPath(lastSelectedIndexPath)
                oldCell?.accessoryType = .None
            }
            
            let newCell = tableView.cellForRowAtIndexPath(indexPath)
            newCell?.accessoryType = .Checkmark
            
            lastSelectedIndexPath = indexPath
        }
        if indexPath.row == 0 {
            AudioServicesPlaySystemSound(SystemSoundID(1006))
        }
        else if indexPath.row == 1 {
            AudioServicesPlaySystemSound(SystemSoundID(1258))
        }
        else if indexPath.row == 2 {
            AudioServicesPlaySystemSound(SystemSoundID(1000))
        }
        else if indexPath.row == 3 {
            AudioServicesPlaySystemSound(SystemSoundID(1006))
        }
        else if indexPath.row == 4 {
            AudioServicesPlaySystemSound(SystemSoundID(1006))
        }
        else if indexPath.row == 5 {
            AudioServicesPlaySystemSound(SystemSoundID(1006))
        }
        else if indexPath.row == 6 {
            AudioServicesPlaySystemSound(SystemSoundID(1006))
        }
        else if indexPath.row == 7 {
            AudioServicesPlaySystemSound(SystemSoundID(1022))
        }
        else if indexPath.row == 8 {
            AudioServicesPlaySystemSound(SystemSoundID(1023))
        }
        else if indexPath.row == 9 {
            AudioServicesPlaySystemSound(SystemSoundID(1024))
        }
        else if indexPath.row == 10 {
            AudioServicesPlaySystemSound(SystemSoundID(1025))
        }
        else {
            AudioServicesPlaySystemSound(SystemSoundID(1026))
        }
        
        
    }
    
    
//        func playSound(soundIndex: Int) {
//            //建立的SystemSoundID对象
//            var startsoundID:SystemSoundID = 0
//            var stopsoundID:SystemSoundID = 1
//            var pomoingsoundID:SystemSoundID = 2
//            
//            let startSoundPath = NSBundle.mainBundle().pathForResource("Start", ofType: "mp3")
//            let stopSoundPath = NSBundle.mainBundle().pathForResource("Stop", ofType: "mp3")
//            let pomoingSoundPath = NSBundle.mainBundle().pathForResource("Pomoing", ofType: "mp3")
//    
//            let startSoundUrl = NSURL(fileURLWithPath: startSoundPath!)
//            let stopSoundUrl = NSURL(fileURLWithPath: stopSoundPath!)
//            let pomoingSoundUrl = NSURL(fileURLWithPath: pomoingSoundPath!)
//    
//            //赋值
//            AudioServicesCreateSystemSoundID(startSoundUrl, &startsoundID)
//            AudioServicesCreateSystemSoundID(stopSoundUrl, &stopsoundID)
//            AudioServicesCreateSystemSoundID(pomoingSoundUrl, &pomoingsoundID)
//            
//            
//            switch soundIndex {
//            case 0:
//                stopSound()
//                //if enableAlarmSound {
//                do {
//                    //添加音频结束时的回调
////                    let proc: AudioServicesSystemSoundCompletionProc =
////                    MyAudioServicesSystemSoundCompletionHandler
////                    AudioServicesAddSystemSoundCompletion(startsoundID, nil, nil, proc,
////                                                          UnsafeMutablePointer(unsafeAddressOf(self)))
////                    
//    
//                    soundPlayer = try AVAudioPlayer(contentsOfURL: stopSoundUrl)} catch _ { }
//                    soundPlayer!.numberOfLoops = 0
//                    soundPlayer!.volume = 1
//                    soundPlayer!.prepareToPlay()
//                    soundPlayer!.play()
//                //}
//            case 1:
//                stopSound()
//               // if enableAlarmSound {
//                    do {soundPlayer = try AVAudioPlayer(contentsOfURL: startSoundUrl)} catch _ { }
//                    soundPlayer!.numberOfLoops = -1
//                    soundPlayer!.volume = 1
//                    soundPlayer!.prepareToPlay()
//                    soundPlayer!.play()
//                //}
//            case 2:
//                stopSound()
//                //if enableTimerSound {
//                    do {soundPlayer = try AVAudioPlayer(contentsOfURL: pomoingSoundUrl)} catch _ { }
//                    soundPlayer!.numberOfLoops = -1
//                    soundPlayer!.volume = 0.2
//                    soundPlayer!.prepareToPlay()
//                    soundPlayer!.play()
//                //}
//    
//            default:
//                if soundPlayer != nil {
//                    soundPlayer!.stop()
//                }
//            }
//        }
//        func stopSound() {
//            if soundPlayer != nil {
//                soundPlayer!.stop()
//            }
//        }
//    
//
//
//    
    
//    func resetChecks() {
//        for i in 0...tableView.numberOfSections - 1 {
//            for j in 0...tableView.numberOfRowsInSection(i) - 1 {
//                if let cell = tableView.cellForRowAtIndexPath(NSIndexPath(forRow: j, inSection: i)) {
//                    cell.accessoryType = .None
//                }
//            }
//        }
//    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
