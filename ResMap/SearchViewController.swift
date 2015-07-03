//
//  SearchViewController.swift
//  ResMap
//
//  Created by hirosawak on 2015/07/02.
//  Copyright (c) 2015年 hirosawak. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {
    
    var keywordLabel = UILabel()
    var keywordBtn = UIButton()
    
    var lanlongLabel = UILabel()
    var rangeLabel = UILabel()
    var lanlongBtn = UIButton()
    var TextField: UITextField = UITextField()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "検索"
        
        var tab = self.tabBarController?.tabBar.frame.height
        
        var windowMargin : CGFloat = 10.0
        var myWidth  = self.view.frame.width - windowMargin*3
        var myHeight = self.view.frame.height - tab!
        var myCellHeight : CGFloat = myHeight / 10
        
        keywordLabel.text = "フリーワード"
        lanlongLabel.text = "現在地から検索する"
        rangeLabel.text = "検索半径"

        keywordLabel.frame = CGRect(x: windowMargin,y: 0 + myCellHeight/2,width: myWidth ,height: myCellHeight - 10)
        //lanlongLabel.frame = CGRect(x: windowMargin,y: 0 + myCellHeight,width: myWidth ,height: myCellHeight - 10)
        
        addBtn(keywordBtn, xPos: windowMargin                 , yPos: myHeight - myCellHeight, text: "検索"   ,sizeX: myWidth/2,sizeY: myCellHeight - 10,tag:1)
        addBtn(lanlongBtn, xPos: windowMargin*2 + myWidth / 2 , yPos: myHeight - myCellHeight, text: "周辺検索",sizeX: myWidth/2,sizeY: myCellHeight - 10,tag:2)
        
        
        self.view.backgroundColor = UIColor.whiteColor()
        self.view.addSubview(keywordLabel)
        
        // UITextFieldを作成する.
        TextField = UITextField(frame: CGRectMake(windowMargin,0 + myCellHeight,myWidth + windowMargin,myCellHeight - 10))
        // 表示する文字を代入する.
        TextField.placeholder = "ここに入力して！"
        // 枠を表示する.
        TextField.borderStyle = UITextBorderStyle.RoundedRect
        // UITextFieldの表示する位置を設定する.
        TextField.layer.position = CGPoint(x:self.view.bounds.width/2,y:100);
        // Viewに追加する.
        self.view.addSubview(TextField)
        
        
        //キーボードを閉じる
        let myTap = UITapGestureRecognizer(target: self, action: "tapGesture:")
        self.view.addGestureRecognizer(myTap)
    }
    
    func addBtn(myButton:UIButton,xPos:CGFloat,yPos:CGFloat, text:String,sizeX:CGFloat,sizeY:CGFloat,tag:Int){
        // サイズを設定する.
        myButton.frame = CGRectMake(xPos,yPos,sizeX,sizeY)
        // 背景色を設定する.
        myButton.backgroundColor = UIColor.grayColor()
        // 枠を丸くする.
        myButton.layer.masksToBounds = true
        // タイトルを設定する(通常時).
        myButton.setTitle("\(text)", forState: UIControlState.Normal)
        myButton.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        // タイトルを設定する(ボタンがハイライトされた時).
        myButton.setTitle("\(text)", forState: UIControlState.Highlighted)
        myButton.setTitleColor(UIColor.blackColor(), forState: UIControlState.Highlighted)
        // コーナーの半径を設定する.
        myButton.layer.cornerRadius = 20.0
        // タグを設定する.
        myButton.tag = tag
        // イベントを追加する.
        myButton.addTarget(self, action: "onClickButton:", forControlEvents: .TouchUpInside)
        // ボタンをViewに追加する.
        self.view.addSubview(myButton)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //ボタンを押した時
    internal func onClickButton(sender: UIButton){
        var result = ResultViewController()
        self.presentViewController(result, animated: true, completion: nil)
    }
    
    //キーボードをしまう処理
    func tapGesture(sender: UITapGestureRecognizer){
        for v in self.view.subviews {
            if(v is UITextField) {
                let txt = v as! UITextField
                if(txt.isFirstResponder()) {
                    txt.resignFirstResponder()
                    return
                }
            }
        }
    }
    
}
