//
//  MainGPSViewController.swift
//  electoulouse
//
//  Created by Antoine Simon on 23/12/2017.
//  Copyright © 2017 antoine simon. All rights reserved.
//

import UIKit
import MapKit
import GoogleMobileAds

class MainGPSViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate{

    @IBOutlet weak var mapGPS: MKMapView!
    
    var bannerView: GADBannerView!

    let regionRadius: CLLocationDistance = 1000
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse {
            mapGPS.showsUserLocation = true
        } else {
            locationManager.requestWhenInUseAuthorization()
        }
        
        mapGPS.delegate = self
        
        //ADD
        bannerView = GADBannerView(adSize: kGADAdSizeBanner)
        addBannerViewToView(bannerView)
        bannerView.adUnitID = "ca-app-pub-4348180862135845/3402359511"
        bannerView.rootViewController = self
        bannerView.load(GADRequest())
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func addBannerViewToView(_ bannerView: GADBannerView) {
        bannerView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(bannerView)
        view.addConstraints(
            [NSLayoutConstraint(item: bannerView,
                                attribute: .bottom,
                                relatedBy: .equal,
                                toItem: bottomLayoutGuide,
                                attribute: .top,
                                multiplier: 1,
                                constant: 0),
             NSLayoutConstraint(item: bannerView,
                                attribute: .centerX,
                                relatedBy: .equal,
                                toItem: view,
                                attribute: .centerX,
                                multiplier: 1,
                                constant: 0)
            ])
    }
    
    func centerMapOnLocation(location: CLLocation) {
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate,
                                                                  regionRadius, regionRadius)
        
        mapGPS.setRegion(coordinateRegion, animated: true)
    }
    
    func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation) {
        centerMapOnLocation(location: userLocation.location!)
    }
}
