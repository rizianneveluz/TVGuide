//
//  TVShowTableViewCell.swift
//  TVGuide
//
//  Created by Rizianne Veluz on 12/08/2018.
//  Copyright © 2018 Rizianne Veluz. All rights reserved.
//

import UIKit

class TVShowTableViewCell: UITableViewCell {

    @IBOutlet weak var channelLogo: UIImageView!
    @IBOutlet weak var showTitle: UILabel!
    @IBOutlet weak var showStartTime: UILabel!
    @IBOutlet weak var showEndTime: UILabel!
    @IBOutlet weak var showRatingLogo: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.channelLogo.contentMode = .scaleAspectFill
        self.showRatingLogo.contentMode = .scaleAspectFill
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
