//
//  MapViewController.swift
//  ResMap
//
//  Created by hirosawak on 2015/06/28.
//  Copyright (c) 2015年 hirosawak. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController, MKMapViewDelegate {
    
    // MapView.
    var myMapView : MKMapView!
    var myLocationManager: CLLocationManager!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // LocationManagerの生成.
        myLocationManager = CLLocationManager()
        
        // 距離のフィルタ.
        myLocationManager.distanceFilter = 100.0
        
        // 精度.
        myLocationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
        
        // セキュリティ認証のステータスを取得.
        let status = CLLocationManager.authorizationStatus()
        
        // まだ認証が得られていない場合は、認証ダイアログを表示.
        if(status == CLAuthorizationStatus.NotDetermined) {
            
            // まだ承認が得られていない場合は、認証ダイアログを表示.
            self.myLocationManager.requestAlwaysAuthorization();
        }
        
        // 位置情報の更新を開始.
        myLocationManager.startUpdatingLocation()
        
        // MapViewの生成.
        myMapView = MKMapView()
        // MapViewのサイズを画面全体に.
        myMapView.frame = self.view.bounds
        // Delegateを設定.
        myMapView.delegate = self
        
        // MapViewをViewに追加.
        self.view.addSubview(myMapView)
        
        // 中心点の緯度経度.
        let myLat: CLLocationDegrees = 35.675224
        let myLon: CLLocationDegrees = 139.737914
        let myCoordinate: CLLocationCoordinate2D = CLLocationCoordinate2DMake(myLat, myLon)
        
        // 縮尺.
        let myLatDist : CLLocationDistance = 500
        let myLonDist : CLLocationDistance = 500
        
        // Regionを作成.
        let myRegion: MKCoordinateRegion = MKCoordinateRegionMakeWithDistance(myCoordinate, myLatDist, myLonDist);
        
        // MapViewに反映.
        myMapView.setRegion(myRegion, animated: true)
        
        
        getApiRest()
        /*
        var api : APIAccess = APIAccess(apiKey: "b5610c8305dddb47631823eb49164137",searchWord: "居酒屋",lat: 35.675224,lng: 139.737914)
        var ResList : [ Restaurant ] = api.getRestList()
        println(ResList.count )
        for i in 0..<ResList.count {
            var shop : Restaurant = ResList[i]
            
            println("aaa")
            // ピンを生成.
            var myPin: MKPointAnnotation = MKPointAnnotation()
            // 座標を設定.
            myPin.coordinate = CLLocationCoordinate2DMake(shop.latitude, shop.longitude)
            // タイトルを設定.
            myPin.title = "\(shop.name)"
            // サブタイトルを設定.
            myPin.subtitle = "\(shop.pr_short)"
            // MapViewにピンを追加.
            myMapView.addAnnotation(myPin)
        }
        */
    }

    // GPSから値を取得した際に呼び出されるメソッド.
    func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) {
        
        // 配列から現在座標を取得.
        var myLocations: NSArray = locations as NSArray
        var myLastLocation: CLLocation = myLocations.lastObject as! CLLocation
        var myLocation:CLLocationCoordinate2D = myLastLocation.coordinate
        
        // 縮尺.
        let myLatDist : CLLocationDistance = 100
        let myLonDist : CLLocationDistance = 100
        
        // Regionを作成.
        let myRegion: MKCoordinateRegion = MKCoordinateRegionMakeWithDistance(myLocation, myLatDist, myLonDist);
        
        // MapViewに反映.
        myMapView.setRegion(myRegion, animated: true)
    }
    
    // Regionが変更した時に呼び出されるメソッド.
    func mapView(mapView: MKMapView!, regionDidChangeAnimated animated: Bool) {
        println("regionDidChangeAnimated")
    }
    
    // 認証が変更された時に呼び出されるメソッド.
    func locationManager(manager: CLLocationManager!, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        switch status{
        case .AuthorizedWhenInUse:
            println("AuthorizedWhenInUse")
        case .AuthorizedAlways:
            println("Authorized")
        case .Denied:
            println("Denied")
        case .Restricted:
            println("Restricted")
        case .NotDetermined:
            println("NotDetermined")
        default:
            println("etc.")
        }
    }
    
    
/*
    func mapView(mapView: MKMapView!, viewForAnnotation annotation: MKAnnotation!) -> MKAnnotationView! {
        if annotation === mapView.userLocation { // 現在地を示すアノテーションの場合はデフォルトのまま
            return nil
        } else {
            let identifier = "annotation"
            if let annotationView = mapView.dequeueReusableAnnotationViewWithIdentifier("annotation") {
                // 再利用できる場合はそのまま返す
                return annotationView
            } else { // 再利用できるアノテーションが無い場合（初回など）は生成する
                let annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: identifier)
                annotationView.image = UIImage(named: "pin.png") // ここで好きな画像を設定します
                annotationView.contentMode = UIViewContentMode.ScaleAspectFit
                annotationView.sizeToFit()
                return annotationView
            }
        }
    }
*/

    func getApiRest() {
        let api = APIAccess(apiKey: "b5610c8305dddb47631823eb49164137",searchWord: "居酒屋",lat: 35.675224,lng: 139.737914)
        api.getRestList() { (restObj) in
            var ResList : [ Restaurant ] = restObj
            println("bbbbbbbbbbbbbbbbbbbb\(ResList.count)")
            for i in 0..<ResList.count {
                var shop : Restaurant = ResList[i]
                
                println("aaa")
                // ピンを生成.
                var myPin: MKPointAnnotation = MKPointAnnotation()
                // 座標を設定.
                myPin.coordinate = CLLocationCoordinate2DMake(shop.latitude, shop.longitude)
                // タイトルを設定.
                myPin.title = "\(shop.name)"
                // サブタイトルを設定.
                myPin.subtitle = "\(shop.pr_short)"
                // MapViewにピンを追加.
                self.myMapView.addAnnotation(myPin)
            }
        }
    }
    
    func onClick() {
        self.navigationController!.pushViewController(ResultViewController(), animated: true)
    }
    
}
