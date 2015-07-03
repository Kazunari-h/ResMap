//
//  APIAccess.swift
//  ResMap
//
//  Created by hirosawak on 2015/07/02.
//  Copyright (c) 2015年 hirosawak. All rights reserved.
//

import Foundation


class APIAccess{
    
    //var restaurant : Restaurant
    var apiKey :String
    var searchWord : String
    var lat : Float
    var lng : Float
    var accURL : String = "http://api.gnavi.co.jp/RestSearchAPI/20150630/?keyid=b5610c8305dddb47631823eb49164137&format=json"
    
    var restList : [Restaurant] = []
    
    internal init(apiKey:String,searchWord:String,lat:Float,lng:Float){
        self.apiKey = apiKey
        self.searchWord = searchWord
        self.lat = lat
        self.lng = lng
        accURL = accURL + "&latitude=\(lat)&longitude=\(lng)&range=3"
    }

    func getAccess(call: () -> ()){
        let URL = NSURL(string: accURL)
        let Req = NSURLRequest(URL: URL!)
        let connection: NSURLConnection = NSURLConnection(request: Req, delegate: self, startImmediately: false)!
        
        NSURLConnection.sendAsynchronousRequest(
            Req,
            queue: NSOperationQueue.mainQueue(),
            completionHandler: self.fetchResponse
        )
    }
    
    func fetchResponse(res: NSURLResponse!, data: NSData!, error: NSError!) {
        let jsonObject : AnyObject! = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: nil)
        println("SampleData0001")
        
        //第一階層
        var test = jsonObject as! NSDictionary
        
        //レストラン群(第二階層)
        var rests : AnyObject? = test["rest"]
        var count : Int = (test.objectForKey("hit_per_page")as! String).toInt()!
        
        //レストラン１つ目
        var rest = (rests as! NSArray)[0] as? NSDictionary
        
        //レストラン一つ目のid
        var id : AnyObject? = rest?.objectForKey("id")
        
        for i in 0..<count{
            //レストランiつ目
            var rest = (rests as! NSArray)[i] as? NSDictionary
            
            //レストランiつ目のid
            var id : String! = rest?.objectForKey("id") as? String
            //レストランiつ目のname
            var name : String! = rest?.objectForKey("name") as? String
            //レストランiつ目のname_kana
            var name_kana : String! = rest?.objectForKey("name_kana") as? String
            //レストランiつ目のurl
            var url : String! = rest?.objectForKey("url") as? String
            //レストランiつ目のtel
            var tel : String! = rest?.objectForKey("tel") as? String
            //レストランiつ目のaddress
            var address : String! = rest?.objectForKey("address") as? String

            //レストランiつ目のpr
            var pr : AnyObject? = rest?.objectForKey("pr")
            var pr_short : String? = (pr as! NSDictionary).objectForKey("pr_short") as? String
            
            //レストランiつ目のurl
            var lat : NSString! = rest?.objectForKey("latitude") as? String
            //レストランiつ目のtel
            var lng : NSString! = rest?.objectForKey("longitude") as? String
            
            var restItem = Restaurant(
                id : id,
                name : name,
                name_kana : name_kana,
                latitude : lat.doubleValue ,
                longitude : lng.doubleValue ,
                category : "Cafe" ,
                url : url,
                image_url : "http://kazunari.hal2016.com/" ,
                qrcode : "http://kazunari.hal2016.com/" ,
                address	: address ,//住所
                tel : tel ,//電話番号
                pr_short : pr_short! //PR文（短:最大50文字）
            )
            
            restList.append(restItem)
            println(id)
            println(name)
            println(pr_short!)
        }


        
        //let res : NSDictionary = jsonObject.objectForKey("hit_per_page") as! NSDictionary
        //let pref : NSArray = res.objectForKey("prefecture") as! NSArray
        //let statusesArray = (jsonObject as? NSArray)[]
        
        
    }
    
    func getRestList(callback: ([Restaurant]) -> Void) -> Void {
        getAccess(){ () in
            println("CCCCCC")
            callback(self.restList)
        }
    }
}
