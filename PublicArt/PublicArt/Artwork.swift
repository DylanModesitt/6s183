//
//  Artwork.swift
//  PublicArt
//
//  Created by William Caruso on 1/28/18.
//  Copyright © 2018 wcaruso. All rights reserved.
//

import MapKit

class Artwork: NSObject, MKAnnotation {
    let title: String?
    let artist: String
    let image: String
    let year: String
    let coordinate: CLLocationCoordinate2D
    
    init(title: String, artist: String, image: String, year: String, coordinate: CLLocationCoordinate2D) {
        self.title = title
        self.artist = artist
        self.image = image
        self.year = year
        self.coordinate = coordinate
        
        super.init()
    }
    
    var subtitle: String? {
        return "\(artist) | \(year)"
    }
}
