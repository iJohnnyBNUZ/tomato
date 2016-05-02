//
//  UserInfo.swift
//  Tomato
//
//  Created by Johnny on 16/4/30.
//  Copyright © 2016年 Johnny. All rights reserved.
//

import UIKit

class UserInfo: NSObject {
    var name: String
    //var deadLine: String
    //var tag: Int
    //var numTomato: Int
    
    //构造方法
    //init(name:String = "", deadLine:String = "", tag:Int = 0, numTomato:Int = 0) {
    init(name:String = "") {
        self.name = name
        //self.deadLine = deadLine
        //self.tag = tag
        //self.numTomato = numTomato
    }
    
    //从nsobject解析回来
    init(coder aDecoder: NSCoder!) {
        self.name = aDecoder.decodeObjectForKey("Name") as! String
        //self.deadLine = aDecoder.decodeObjectForKey("Phone") as! String
        //self.tag = aDecoder.decodeObjectForKey("Tag") as! Int
        //self.numTomato = aDecoder.decodeObjectForKey("NumTomato") as! Int
    }
    
    //编码成object
    func encodeWithCoder(aCoder: NSCoder!) {
        aCoder.encodeObject(name,forKey: "Name")
        //aCoder.encodeObject(deadLine,forKey: "Phone")
        //aCoder.encodeObject(tag,forKey: "Tag")
        //aCoder.encodeObject(numTomato,forKey: "NumTomato")
    }
}
