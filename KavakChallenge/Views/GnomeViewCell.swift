//
//  GnomeViewCell.swift
//  KavakChallenge
//
//  Created by Pablo Ramirez on 6/27/19.
//  Copyright © 2019 Pablo Ramirez. All rights reserved.
//

import UIKit
import AlamofireImage

class GnomeViewCell: UICollectionViewCell {

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var gnomeImage: UIImageView!
    @IBOutlet weak var gnomeName: UILabel!
    @IBOutlet weak var gnomeAge: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        containerView.layer.cornerRadius = 5
        containerView.layer.shadowColor = UIColor.black.cgColor
        containerView.layer.shadowOpacity = 0.5
        containerView.layer.shadowOffset = CGSize(width: 0, height: 1)
        containerView.layer.shadowRadius = 1
    }
    
    func initCell(gnome: Brastlewark, viewModelRef: MainViewModel, index: Int){
        
        gnomeName.text = gnome.name
        gnomeAge.text = "Age: \(gnome.age)"
        gnomeImage.tag = index
        gnomeImage.downloadImage(from: "\(gnome.thumbnail)")
        //gnomeImage.downloadImageWithAF(urlStr: gnome.thumbnail)
    }

}

