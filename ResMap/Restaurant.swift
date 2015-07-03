//
//  Restaurant.swift
//  ResMap
//
//  Created by hirosawak on 2015/07/02.
//  Copyright (c) 2015年 hirosawak. All rights reserved.
//

public struct Restaurant {
    var id : String //店舗ID
    var name : String //店舗名称
    var name_kana : String //店舗名称（カタカナ）
    var latitude :Double //緯度
    var longitude:Double //経度
    var category : String //フリーワードカテゴリー
    var url : String //PCサイトURL
    var image_url : String //店舗画像
    var qrcode : String	//QRコード画像のURL
    var address	: String //住所
    var tel : String //電話番号
    var pr_short : String //PR文（短:最大50文字）
}
