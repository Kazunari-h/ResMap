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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // MapViewの生成.
        myMapView = MKMapView()
        // MapViewのサイズを画面全体に.
        myMapView.frame = self.view.bounds
        // Delegateを設定.
        myMapView.delegate = self
        // MapViewをViewに追加.
        self.view.addSubview(myMapView)
        // 中心点の緯度経度.
        let myLat: CLLocationDegrees = 37.506804
        let myLon: CLLocationDegrees = 139.930531
        let myCoordinate: CLLocationCoordinate2D = CLLocationCoordinate2DMake(myLat, myLon)
        // 縮尺.
        let myLatDist : CLLocationDistance = 100
        let myLonDist : CLLocationDistance = 100
        // Regionを作成.
        let myRegion: MKCoordinateRegion = MKCoordinateRegionMakeWithDistance(myCoordinate, myLatDist, myLonDist);
        // MapViewに反映.
        myMapView.setRegion(myRegion, animated: true)
        var Lat: [ CLLocationDegrees ] = [37.506704,37.506804,37.506904,37.506504,37.506404,37.506304]
        var Lon: [ CLLocationDegrees ] = [139.930531,139.930531,139.930531,139.930531,139.930531,139.930531]
        for i in 0...5 {
            // ピンを生成.
            var myPin: MKPointAnnotation = MKPointAnnotation()
            // 座標を設定.
            myPin.coordinate = CLLocationCoordinate2DMake(Lat[i], Lon[i])
            // タイトルを設定.
            myPin.title = "タイトル\(i)"
            // サブタイトルを設定.
            myPin.subtitle = "サブタイトル"
            // MapViewにピンを追加.
            myMapView.addAnnotation(myPin)
        }
    }
    
    func mapView(mapView: MKMapView!, viewForAnnotation annotation: MKAnnotation!) -> MKAnnotationView! {
        if annotation === mapView.userLocation { // 現在地を示すアノテーションの場合はデフォルトのまま
            return nil
        } else {
            let identifier = "annotation"
            if let annotationView = mapView.dequeueReusableAnnotationViewWithIdentifier("annotation") { // 再利用できる場合はそのまま返す
                return annotationView
            } else { // 再利用できるアノテーションが無い場合（初回など）は生成する
                let annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: identifier)
                annotationView.image = UIImage(named: "pin.png") // ここで好きな画像を設定します
                return annotationView
            }
        }
    }
    
}
