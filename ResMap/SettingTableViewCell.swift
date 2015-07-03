//
//  SettingTableViewCell.swift
//  ResMap
//
//  Created by hirosawak on 2015/07/02.
//  Copyright (c) 2015年 hirosawak. All rights reserved.
//

import UIKit


class SettingTableViewCell: UITableViewCell{
    
    var titleLabel = UILabel();
    var contentLabel = UILabel();
    // Swicthを作成する.
    var mySwicth: UISwitch = UISwitch()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String!){
        //First Call Super
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        mySwicth.layer.position = CGPoint(x: self.frame.width , y: self.frame.height/2)
        // Swicthの枠線を表示する.
        mySwicth.tintColor = UIColor.blackColor()
        // SwitchをOnに設定する.
        mySwicth.on = true
        
        // SwitchをViewに追加する.
        self.addSubview(mySwicth)
        
        titleLabel = UILabel(frame: CGRectMake(10, 2, 300, 15));
        titleLabel.text = "";
        titleLabel.font = UIFont.systemFontOfSize(12)
        self.addSubview(titleLabel);
        
        contentLabel = UILabel(frame: CGRectMake(10, 20, 300, 15));
        contentLabel.text = "";
        contentLabel.font = UIFont.systemFontOfSize(22)
        self.addSubview(contentLabel);
    }
    
    required init(coder aDecoder: NSCoder){
        super.init(coder: aDecoder)
    }
}