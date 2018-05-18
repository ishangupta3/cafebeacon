//
//  MealTableViewCell.swift
//  IndoorInBackground
//
//  Created by ishgupta on 5/1/18.
//  Copyright © 2018 Estimote Inc. All rights reserved.
//

import UIKit

class MealTableViewCell: UITableViewCell {
    
    
    
    @IBOutlet weak var dateLabel: UILabel!

    @IBOutlet weak var rating: RatingControl!
    @IBOutlet weak var nameLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
