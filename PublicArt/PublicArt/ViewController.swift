//
//  ViewController.swift
//  PublicArt
//
//  Created by William Caruso on 1/28/18.
//  Copyright © 2018 wcaruso. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation
import SwiftyJSON

class ViewController: UIViewController {

    @IBOutlet weak var mapView: MKMapView!
    
    var currentArtwork:Artwork?
    
    let initialLocation = CLLocation(latitude: 42.3589, longitude: -71.0915)
    let regionRadius: CLLocationDistance = 1000

    override func viewDidLoad() {
        super.viewDidLoad()
        centerMapOnLocation(location: initialLocation)
        mapView.delegate = self
        loadArtwork()
        
    }


    // MARK: - Helper Methods
    func loadArtwork() {
        if let path = Bundle.main.path(forResource: "public_art", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let json = try JSON(data: data)
                for (_, artJSON) in json["public_art"] {
                    print("\(artJSON)")
                    let lat:Double = artJSON["latitude"].double!
                    let long:Double = artJSON["longitude"].double!
                    let loc = CLLocationCoordinate2D(latitude: lat, longitude: long)
                    let artwork = Artwork(title: artJSON["title"].string!,
                                          artist: artJSON["artist"].string!,
                                          image: artJSON["image"].string!,
                                          year: artJSON["year"].string!,
                                          coordinate: loc)
                    mapView.addAnnotation(artwork)
                }
            } catch {
                // handle error
            }
        }
    }
    
    func centerMapOnLocation(location: CLLocation) {
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate,
                                                                  regionRadius, regionRadius)
        mapView.setRegion(coordinateRegion, animated: true)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "moreDetail") {
            let destVC:DetailViewController = segue.destination as! DetailViewController
            destVC.artwork = currentArtwork
        }
    }
}

extension ViewController: MKMapViewDelegate {
    // 1
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        // 2
        guard let annotation = annotation as? Artwork else { return nil }
        // 3
        let identifier = "marker"
        var view: MKMarkerAnnotationView
        // 4
        if let dequeuedView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
            as? MKMarkerAnnotationView {
            dequeuedView.annotation = annotation
            view = dequeuedView
        } else {
            // 5
            view = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            view.canShowCallout = true
            view.calloutOffset = CGPoint(x: -5, y: 5)
            view.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
        }
        return view
    }
    
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        currentArtwork = view.annotation as? Artwork
        if control == view.rightCalloutAccessoryView {
            performSegue(withIdentifier: "moreDetail", sender: self)
        }
        
    }

}
