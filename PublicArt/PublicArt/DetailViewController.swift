//
//  DetailViewController.swift
//  PublicArt
//
//  Created by William Caruso on 1/28/18.
//  Copyright © 2018 wcaruso. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitle: UILabel!
    
    var artwork:Artwork? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let art = artwork {
            imageView.image = UIImage(named: art.image)
            titleLabel.text = art.title
            subtitle.text = art.subtitle
        }
    }

}
