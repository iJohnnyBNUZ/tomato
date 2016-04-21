//
//  TableViewController.swift
//  TomotoTime2
//
//  Created by Ponta on 16/4/11.
//  Copyright © 2016年 Ponta. All rights reserved.
//

import UIKit

class Settings: UITableViewController {
    var pickOption = ["25 min", "30 min", "35 min", "40 min", "45 min","50 min","55 min","60 min"]
    
    var voiceOption = ["5 min", "10 min", "15 min", "20 min", "25 min","30 min"]
    
    var pickerVisible = false
    var pickerVisible1 = false
    var pickerVisible2 = false

    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var tomatotime: UITableViewCell!
    @IBOutlet weak var dateChanged: UIPickerView!
    @IBOutlet weak var relaxChanged: UIPickerView!
    @IBOutlet weak var relaxdate: UILabel!
    @IBOutlet weak var voiceChanged: UIPickerView!
    @IBOutlet weak var voiceLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
    
        dateChanged.selectRow(0,inComponent:0,animated:true)
        relaxChanged.selectRow(0,inComponent:0,animated:true)
        voiceChanged.selectRow(0,inComponent:0,animated:true)
        tableView.contentInset = UIEdgeInsetsMake(20, 0, 0, 0)
        tableView.tableFooterView = UIView(frame: CGRectZero)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        if pickerView == dateChanged{
            return pickOption.count
        }
        else if pickerView == relaxChanged{
            return pickOption.count
        }
        else if pickerView == voiceChanged{
            return voiceOption.count
        }
        return 0

    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String
    {
        if pickerView == dateChanged{
            return pickOption[row]
        }
        else if pickerView == relaxChanged{
            return pickOption[row]
        }
        else if pickerView == voiceChanged{
            return voiceOption[row]
        }
        
        return ""
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        if pickerView == dateChanged{
            date.text = pickOption[row]
            //pickerVisible = false
        }
        else if pickerView == relaxChanged{
            relaxdate.text = pickOption[row]
            //pickerVisible1 = false
        }
        else if pickerView == voiceChanged{
            voiceLabel.text = voiceOption[row]
            //pickerVisible2 = false
        }
        pickerVisible = false
        pickerVisible1 = false
        pickerVisible2 = false
    }

    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if indexPath.row == 0 && indexPath.section == 0{
            pickerVisible = !pickerVisible
        }
        if indexPath.row == 2 && indexPath.section == 0{
            pickerVisible1 = !pickerVisible1
        }
        if indexPath.row == 1 && indexPath.section == 1{
            pickerVisible2 = !pickerVisible2
        }
        tableView.reloadData()
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if indexPath.row == 1 && indexPath.section == 0 {
            if pickerVisible == true{
                return 165.0
            }
            else {
                return 0.0
            }
        }
        ///////////////////////////////////////////////////////////////////////////////
 
        if indexPath.row == 3 && indexPath.section == 0 {
            if pickerVisible1 == true{
                return 165.0
            }
            else {
                return 0.0
            }
        }
        ///////////////////////////////////////////////////////////////////////////////

        if indexPath.row == 2 && indexPath.section == 1 {
            if pickerVisible2 == true{
                return 165.0
            }
            else {
                return 0.0
            }
        }

        return 44.0
    }
    
    override func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 44.0
    }
}