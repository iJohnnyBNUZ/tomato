//
//  TableViewController.swift
//  TomotoTime2
//
//  Created by Ponta on 16/4/11.
//  Copyright © 2016年 Ponta. All rights reserved.
//

import UIKit

class Settings: UITableViewController {
    var pickOption = ["5 min", "10 min", "15 min", "20 min", "25 min","30 min"]
    
    var pickerVisible = false
    var pickerVisible1 = false
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var tomatotime: UITableViewCell!
    @IBOutlet weak var dateChanged: UIPickerView!
    @IBOutlet weak var relaxChanged: UIPickerView!
    @IBOutlet weak var relaxdate: UILabel!
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickOption.count ;
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickOption[row];
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerVisible {
            date.text = pickOption[row]
        }
        else if pickerVisible1{
            relaxdate.text = pickOption[row]
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
    
        tableView.contentInset = UIEdgeInsetsMake(20, 0, 0, 0)
        tableView.tableFooterView = UIView(frame: CGRectZero)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if indexPath.row == 0 && indexPath.section == 0{
            pickerVisible = !pickerVisible
            
            tableView.reloadData()
        }
        if indexPath.row == 2 && indexPath.section == 0{
            pickerVisible1 = !pickerVisible1
            
            tableView.reloadData()
        }
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if indexPath.row == 0 && indexPath.section == 0{
            return 44.0
        }
        
        if indexPath.row == 1 && indexPath.section == 0 {
            if pickerVisible == true{
                return 165.0
            }
            else {
                return 0.0
            }
        }
        
        if indexPath.row == 2 && indexPath.section == 0{
            return 44.0
        }
        
        if indexPath.row == 3 && indexPath.section == 0 {
            if pickerVisible1 == true{
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