//
//  ListController.swift
//  Tomato
//
//  Created by Fantaaaa on 16/4/23.
//  Copyright © 2016年 Johnny. All rights reserved.
//

import UIKit

class ListController: UIViewController,UITableViewDelegate, UITableViewDataSource,UITextFieldDelegate,UIGestureRecognizerDelegate {

    @IBOutlet weak var quickTask: UITextField!
    @IBOutlet var tableview: UITableView!
    var dictData : NSDictionary!
    var listGroupName : NSArray!
    //var listTeam :NSArray = []
    var name:String = ""  //用于传递任务名称
    var deadline:String = ""
    var tag:Int = 0
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.whiteColor()]
        
        quickTask.delegate = self
        quickTask.placeholder = "快速添加待办事件"
        
        //dataModel.loadData()
        
        let nib = UINib(nibName:  "ListCell",bundle: nil)
        tableview.registerNib(nib, forCellReuseIdentifier: "cell")
        self.tableview.separatorStyle = UITableViewCellSeparatorStyle.None
        self.tableview.tableFooterView = UIView()
        
        //绑定对长按的响应
        var longPress =  UILongPressGestureRecognizer(target:self,
                                                      action:Selector("tableviewCellLongPressed:"))
        //代理
        longPress.delegate = self
        longPress.minimumPressDuration = 0.5
        //将长按手势添加到需要实现长按操作的视图里
        self.tableview!.addGestureRecognizer(longPress)
        
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
            ListVc.listDeadLine = deadline
            ListVc.listTag = tag
        }
    }

    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        print("Row \(indexPath.row) selected")
        name = dataModel.userList[indexPath.row].name
        deadline = dataModel.userList[indexPath.row].deadLine
        tag = dataModel.userList[indexPath.row].tag
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
    
    //长按表格
    func tableviewCellLongPressed(gestureRecognizer:UILongPressGestureRecognizer)
    {
        if (gestureRecognizer.state == UIGestureRecognizerState.Ended)
        {
            print("UIGestureRecognizerStateEnded");
            //在正常状态和编辑状态之间切换
            if(self.tableview!.editing == false){
                self.tableview!.setEditing(true, animated:true)
            }
            else{
                self.tableview!.setEditing(false, animated:true)
            }
        }
    }
    
    //在编辑状态，可以拖动设置cell位置
    func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    //移动cell事件
    func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath,
                   toIndexPath: NSIndexPath) {
        if fromIndexPath != toIndexPath{
            //获取移动行对应的值
            var itemValue:UserInfo = dataModel.userList[fromIndexPath.row]
            //删除移动的值
            dataModel.userList.removeAtIndex(fromIndexPath.row)
            //如果移动区域大于现有行数，直接在最后添加移动的值
            if toIndexPath.row > dataModel.userList.count{
                dataModel.userList.append(itemValue)
            }else{
                //没有超过最大行数，则在目标位置添加刚才删除的值
                dataModel.userList.insert(itemValue, atIndex:toIndexPath.row)
            }
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
