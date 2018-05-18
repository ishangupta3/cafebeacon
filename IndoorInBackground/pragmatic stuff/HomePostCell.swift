//
//  HomePostCell.swift
//  IndoorInBackground
//
//  Created by ishgupta on 3/27/18.
//  Copyright © 2018 Estimote Inc. All rights reserved.
//

import UIKit
import Foundation
class HomePostCell: UICollectionViewCell {
    
    
    let foodTitleView: UIImageView = {
        let image = UIImageView()
        image.clipsToBounds = true
        image.backgroundColor = .red
        return image
    }()
    
    let photoImageView: UIImageView = {
        let image = UIImageView()
        image.clipsToBounds = true
        image.contentMode = .scaleAspectFill
        image.backgroundColor = .blue
        return image
    }()
    
    let foodLabel: UILabel = {
        let label = UILabel()
        label.text = "TEMPLATES"
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.font = UIFont(name: "AvenirNext-Regular", size: 40.0)
        label.textColor = .white
        return label
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(foodTitleView)
        addSubview(photoImageView)
        addSubview(foodLabel)
        
        
        foodTitleView.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: nil, paddingTop: 8, paddingLeft: 8, paddingBottom: 0, paddingRight: 0, width: 40, height: 40)
        
        photoImageView.anchor(top: foodTitleView.bottomAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 8, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        
        foodLabel.anchor(top: topAnchor, left: foodTitleView.rightAnchor, bottom: photoImageView.topAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 8, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        
    }
    
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
