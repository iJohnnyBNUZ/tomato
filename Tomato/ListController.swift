//
//  ListController.swift
//  Tomato
//
//  Created by Fantaaaa on 16/4/23.
//  Copyright © 2016年 Johnny. All rights reserved.
//

import UIKit

class ListController: UIViewController,UITableViewDelegate, UITableViewDataSource,UITextFieldDelegate{

    @IBOutlet weak var quickTask: UITextField!
    @IBOutlet var tableview: UITableView!
    var dictData : NSDictionary!
    var listGroupName : NSArray!
    //var listTeam :NSArray = []
    var name:String = ""  //用于传递任务名称
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.whiteColor()]
        
        quickTask.delegate = self
        quickTask.placeholder = "快速添加待办事件"
        
        dataModel.loadData()
        
        let nib = UINib(nibName:  "ListCell",bundle: nil)
        tableview.registerNib(nib, forCellReuseIdentifier: "cell")
        self.tableview.separatorStyle = UITableViewCellSeparatorStyle.None
        self.tableview.tableFooterView = UIView()
        
    }
    
    override func viewDidAppear(animated: Bool) {
        tableview.reloadData()
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("显示数量:\(dataModel.userList.count)")
        return dataModel.userList.count
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell: ListCell = self.tableview.dequeueReusableCellWithIdentifier("cell")! as! ListCell
        cell.selectionStyle = UITableViewCellSelectionStyle.None
        cell.listLabel.text = dataModel.userList[indexPath.row].name
        return cell
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if(segue.identifier == "DetailsView"){
            var ListVc:SpeTableViewController = segue.destinationViewController as! SpeTableViewController
            ListVc.isComplite = true
            ListVc.listName = name
        }
    }

    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        print("Row \(indexPath.row) selected")
        name = dataModel.userList[indexPath.row].name
        performSegueWithIdentifier("DetailsView", sender: self)
    }
    
    //删除操作
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == UITableViewCellEditingStyle.Delete {
            print("删除/(dataModel.userList[indexPath.row])")
            dataModel.userList.removeAtIndex(indexPath.row)
            dataModel.saveData()
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Automatic)
        }
    }
    
    //return关闭键盘
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        if ((quickTask.text) != "") {
            dataModel.userList.append(UserInfo(name: quickTask.text!))
            print("save")
            dataModel.saveData()
            dataModel.loadData()
            tableview.reloadData()
            quickTask.text = ""
            //performSegueWithIdentifier("toListView", sender: self)
        }

        textField.resignFirstResponder()
        return true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
