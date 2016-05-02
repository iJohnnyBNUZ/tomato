//
//  DataModel.swift
//  Tomato
//
//  Created by Johnny on 16/4/30.
//  Copyright © 2016年 Johnny. All rights reserved.
//

import UIKit

class DataModel: NSObject {

    var userList = [UserInfo] ()
    
    override init() {
        super.init()
        //print("沙盒文件夹路径:\(documentsDirectory())")
        //print("数据文件路径:\(dataFilePath())")
    }
    
    //保存数据
    func saveData() {
        var data = NSMutableData()
        //申明一个归档处理对象
        var archiver = NSKeyedArchiver(forWritingWithMutableData: data)
        //将lists以对应Checklist关键字进行编码
        archiver.encodeObject(userList, forKey: "userList")
        //编码结束
        archiver.finishEncoding()
        //数据写入
        data.writeToFile(dataFilePath(), atomically: true)
    }
    
    //读取数据
    func loadData() {
        //获取本地数据文件地址
        let path = self.dataFilePath()
        //声明文件管理器
        let defaultManager = NSFileManager()
        //通过文件地址判断数据文件是否存在
        if defaultManager.fileExistsAtPath(path) {
            //读取文件数据
            let data = NSData(contentsOfFile: path)
            //解码器
            let unarchiver = NSKeyedUnarchiver(forReadingWithData: data!)
            //通过归档时设置的关键字Checklist还原lists
            userList = unarchiver.decodeObjectForKey("userList") as! Array
            //print(userList[0].deadLine)
            print("加入数量:\(userList.count)")
            //print(userList[0].tag)
            //print(userList[0].numTomato)
            //结束解码
            unarchiver.finishDecoding()
        }
        else {
            saveData()
        }

    }
    
    //获取沙盒文件夹路径
    func documentsDirectory()->String {
        var paths = NSSearchPathForDirectoriesInDomains(
            NSSearchPathDirectory.DocumentationDirectory,NSSearchPathDomainMask.UserDomainMask,true)
        var documentsDirectory:String = paths.first! as String
        return documentsDirectory
    }
    
    //获取数据文件地址
    func dataFilePath ()->String{
        return self.documentsDirectory().stringByAppendingString("userList.plist")
    }
}
