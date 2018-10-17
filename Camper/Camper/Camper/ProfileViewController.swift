//
//  ProfileViewController.swift
//  Camper
//
//  Created by Ertheo Siswadi on 9/14/18.
//  Copyright © 2018 Ertheo Siswadi. All rights reserved.
//

import Foundation
import UIKit
import MapKit

class ProfileViewController: UIViewController {
    
    var profile : [String:Any] = ["":""]
    
    @IBOutlet weak var profpic: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var ageValue: UILabel!
    @IBOutlet weak var ageKey: UILabel!
    @IBOutlet weak var tripKey: UILabel!
    @IBOutlet weak var tripValue: UILabel!
    @IBOutlet weak var friendsValue: UILabel!
    @IBOutlet weak var friendsKey: UILabel!
    @IBOutlet weak var favlocLabel: UILabel!
    @IBOutlet weak var locPinImageView: UIImageView!
    @IBOutlet weak var mapView: MKMapView!
    
    let regionRadius : CLLocationDistance = 1000
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib
        //favlocLabel.text = profile["favlocation"] as? String
        
        profpic.frame.size.height = profpic.frame.size.width
        profpic.layer.cornerRadius = profpic.frame.size.width/2
        nameLabel.text = profile["name"] as! String

        let age = ageCalculator(mdy: profile["birthdate"] as! String)
        ageValue.text = String(age)
        
        let my_location = CLLocation(latitude: 34.053737, longitude: -118.442138)
        centerMapOnLocation(location: my_location)
        
        let annotation = MKPointAnnotation()
        annotation.coordinate = CLLocationCoordinate2D(latitude: 34.053737, longitude: -118.442138)
        annotation.title = "Home"
        mapView.addAnnotation(annotation)
        
        tripValue.text = "10"
        friendsValue.text = "213"
    }
    func centerMapOnLocation(location location:CLLocation)
    {
        let coordinate = MKCoordinateRegionMakeWithDistance(location.coordinate, regionRadius, regionRadius)
        mapView.setRegion(coordinate, animated: true)
    }
    func ageCalculator(mdy birthdate:String) -> Int
    {
        let date = Date()
        let calendar = Calendar.current
        let y_now = calendar.component(Calendar.Component.year, from: date)
        let m_now = calendar.component(Calendar.Component.month, from: date)
        let d_now = calendar.component(Calendar.Component.day, from: date)
        
        let bdate = dateParser(date: birthdate)
        let y_given = Int(bdate[2])!
        let m_given = Int(bdate[0])!
        let d_given = Int(bdate[1])!
        
        var age = y_now - y_given
        
        if m_now < m_given
        {
            age -= 1
        }
        else if m_now == m_given
        {
            if d_now < d_given
            {
                age -= 1
            }
        }
        return age
    }
    func dateParser(date d:String) -> [String]
    {
        let arr = d.components(separatedBy: "/")
        print(arr)
        return arr
    }
}
