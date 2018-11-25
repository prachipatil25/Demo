//
//  ViewController.swift
//  AppleMap
//
//  Created by Prachi Nilesh patil on 30/09/18.
//  Copyright © 2018 prachi. All rights reserved.
//

import UIKit
import MapKit
class ViewController: UIViewController{
    var arrAnnotationList: NSArray? = []
    
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var segmetout: UISegmentedControl!
    
    @IBAction func segmentAction(_ sender: Any) {
        
        let segment : UISegmentedControl = sender as! UISegmentedControl
        print(segment)
        
if segment.selectedSegmentIndex == 0 {
    mapView.mapType = MKMapType.standard
    }
else if segment.selectedSegmentIndex==1
{
        mapView.mapType = MKMapType.hybrid
    }
else if segment.selectedSegmentIndex==2
{
      mapView.mapType = MKMapType.satellite
    }
else
{
    mapView.mapType = MKMapType.hybridFlyover
    }
        
}
    override func viewDidLoad() {
        super.viewDidLoad()
      //  setRegion()
      //  addPinPoint()
        fetchPlist()
    }
    
    private func fetchPlist(){
        let bundle = Bundle.main
        let strPath = bundle.path(forResource: "Property List", ofType: "plist")
        arrAnnotationList = NSArray.init(contentsOfFile: strPath!)
        
        if let _ = arrAnnotationList, (arrAnnotationList?.count)! > 0{
            let dict: Dictionary<String,Any> = arrAnnotationList![0] as! Dictionary<String, Any>
            let latitude:Double = dict["lat"] as! Double
            let longitude:Double = dict["lng"] as! Double
            let span = MKCoordinateSpanMake(0.100, 0.100)
            let clcoordinate2D = CLLocationCoordinate2DMake(latitude, longitude)
            let region = MKCoordinateRegionMake(clcoordinate2D, span)
            mapView.region = region
            addPinPoints()
        }
   
    
    
    }
    private func addPinPoints(){
        for index in 0...(arrAnnotationList?.count)! - 1{
            let dict: Dictionary<String,Any> = arrAnnotationList![index] as! Dictionary<String, Any>
            let latitude:Double = dict["lat"] as! Double
            let longitude:Double = dict["lng"] as! Double
            let clcoordinate2D = CLLocationCoordinate2DMake(latitude, longitude)
            let annotation = MKPointAnnotation()
            annotation.coordinate = clcoordinate2D
            annotation.title = dict["title"] as? String
            annotation.subtitle = dict ["subtitle"] as?String
            mapView.addAnnotation(annotation)
        }
        
        
        
        
    }
  
    private func setRegion(){
        let latitude = 18.52
        let longitude = 73.85
        let span = MKCoordinateSpanMake(0.100, 0.100)
        let coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        let region = MKCoordinateRegionMake(coordinate, span)
        mapView.region=region
    }
    
    private func addPinPoint(){
        let latitude = 18.53
        let longitude = 73.85
        let coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        let annotation = MKPointAnnotation.init()
        annotation.coordinate = coordinate
        annotation.title = "Pune"
        annotation.subtitle = "Pimpri"
        mapView.addAnnotation(annotation)
        
    }
   
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }


}

