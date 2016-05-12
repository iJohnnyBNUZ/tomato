//
//  SpeTableViewController.swift
//  tomato
//
//  Created by Fantaaaa on 16/4/20.
//  Copyright © 2016年 aaa. All rights reserved.
//

import UIKit

var dataModel = DataModel()

class SpeTableViewController: UITableViewController,UITextFieldDelegate {
    @IBOutlet weak var btnTag1: UIButton!
    @IBOutlet weak var btnTag2: UIButton!
    @IBOutlet weak var btnTag3: UIButton!
    @IBOutlet weak var btnTag4: UIButton!
    @IBOutlet weak var numOfTomato: UILabel!
    
    @IBOutlet weak var writeTextField: UITextField!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var PickerCell: UITableViewCell!
    @IBOutlet weak var DatePicker: UIDatePicker!
    @IBOutlet weak var DeleteBtn: UIButton!
    @IBOutlet var tableview: UITableView!
    var isComplite = false
    var listName:String = ""
    var listDeadLine:String = ""
    var listTag:Int = 0
    var pickerVisible = false
    
    @IBAction func datepickerAction(sender: AnyObject){
        var  dateFormatter = NSDateFormatter()
        //设置日期格式
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
        var strDate = dateFormatter.stringFromDate(DatePicker.date)
        timeLabel.text = strDate
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableview.separatorStyle = UITableViewCellSeparatorStyle.None
        
        writeTextField.delegate = self
        writeTextField.placeholder = "请输入待办事件"
        DeleteBtn.layer.cornerRadius = 5
        self.automaticallyAdjustsScrollViewInsets = false
        
        //初始化显示的数据
        if isComplite == true {
            writeTextField.textColor = UIColor.lightGrayColor()
            writeTextField.userInteractionEnabled = false
            writeTextField.text = listName
            timeLabel.text = listDeadLine
            switch listTag {
            case 1:
                btnTag2.hidden = true
                btnTag3.hidden = true
                btnTag4.hidden = true
            case 2:
                btnTag1.hidden = true
                btnTag3.hidden = true
                btnTag4.hidden = true
            case 3:
                btnTag1.hidden = true
                btnTag2.hidden = true
                btnTag4.hidden = true
            case 4:
                btnTag1.hidden = true
                btnTag2.hidden = true
                btnTag3.hidden = true
            default:
                btnTag1.hidden = true
                btnTag2.hidden = true
                btnTag3.hidden = true
                btnTag3.hidden = true
            }
            DeleteBtn.setTitle("好", forState: UIControlState.Normal)
        }else {
            writeTextField.textColor = UIColor.blackColor()
            writeTextField.userInteractionEnabled = true
            DeleteBtn.setTitle("保存", forState: UIControlState.Normal)
        }
    }
    
//    func onCreateData() {
//        print("创建数据")
//        dataModel.userList.append(UserInfo(name: writeTextField.text!))
//    }
    
    @IBAction func saveBtn(sender: AnyObject) {
        if ((writeTextField.text) != "") {
            dataModel.userList.append(UserInfo(name: writeTextField.text!,deadLine: timeLabel.text!,tag: listTag, numTomato: 4))
            print("save")
            dataModel.saveData()
            dataModel.loadData()
            performSegueWithIdentifier("toListView", sender: self)
        }
        else {
            shakeAnimation(writeTextField)
        }
    }
    
    //判断tag的点击
    @IBAction func acTag1(sender: AnyObject) {
        print("Tag 1 selected")
        //btnTag1.setImage(UIImage(contentsOfFile: "tagSelect1"), forState:.Normal)
        listTag = 1
    }
    @IBAction func acTag2(sender: AnyObject) {
        print("Tag 2 selected")
        listTag = 2
    }
    @IBAction func acTag3(sender: AnyObject) {
        print("Tag 3 selected")
        listTag = 3
    }
    @IBAction func acTag4(sender: AnyObject) {
        print("Tag 4 selected")
        listTag = 4
    }
    
    //实现picker的隐藏
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if indexPath.row == 0 && indexPath.section == 1{
            pickerVisible = !pickerVisible
            print(pickerVisible)
        }
        print(pickerVisible)
        tableview.reloadData()
        tableview.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if indexPath.row == 1 && indexPath.section == 1 {
            if pickerVisible == true{
                return 165.0
            }
            else {
                return 0.0
            }
        }
        else if indexPath.row == 0 && indexPath.section == 0{
            return 83.0
        }
        else if indexPath.section == 5 {
            return 91.0
        }
        return 44.0
    }
    
    //输入栏shake
    func shakeAnimation(sender: AnyObject) {
        let animation = CAKeyframeAnimation()
        
        animation.keyPath = "position.x"
        animation.values = [0, 10, -10, 10, 0]
        animation.keyTimes = [0, 1/6.0, 3/6.0, 5/6.0, 1]
        animation.duration = 0.4
        animation.additive = true
        sender.layer.addAnimation(animation, forKey: "shake")
    }
    
    //return关闭键盘
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    //override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
    // #warning Incomplete implementation, return the number of sections
    // return 6
    //}
    
    // override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    // #warning Incomplete implementation, return the number of rows
    //   return 1
    // }
    
    /*
     override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
     let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath)
     
     // Configure the cell...
     
     return cell
     }
     */
    
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
