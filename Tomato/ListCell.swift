//
//  ListCell.swift
//  Tomato
//
//  Created by Fantaaaa on 16/4/23.
//  Copyright © 2016年 Johnny. All rights reserved.
//

import UIKit

class ListCell: UITableViewCell {

    @IBOutlet var view: UIView!
    @IBOutlet var checkBtn: UIButton!
    @IBOutlet var listLabel: UILabel!
    @IBAction func checkedBtn(sender: AnyObject) {
       
    self.checkBtn.selected = !self.checkBtn.selected
        
    //任务描述划线
    var textAttributes = [:] //初始化一个空的NSDictionary
    if (sender.selected != nil) {
        textAttributes = [NSStrikethroughStyleAttributeName: NSUnderlineStyle.StyleSingle.rawValue]
        }
    if(self.checkBtn.selected){
        listLabel.attributedText = NSMutableAttributedString(string: listLabel.text!, attributes: textAttributes as! [String : AnyObject]);
        view.reloadInputViews()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
                // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
