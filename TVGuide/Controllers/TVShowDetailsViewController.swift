//
//  TVShowDetailsViewController.swift
//  TVGuide
//
//  Created by Rizianne Veluz on 12/08/2018.
//  Copyright © 2018 Rizianne Veluz. All rights reserved.
//

import UIKit

class TVShowDetailsViewController: UIViewController {

    var showTitle: String?
    var showStartTime: String?
    var showEndTime: String?
    var showRatingLogo: UIImage?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let detailsView = Bundle.main.loadNibNamed("TVShowDetailsView", owner: self, options: nil)?.first as! TVShowDetailsView
        detailsView.showTitle.text = showTitle
        detailsView.showStartTime.text = showStartTime
        detailsView.showEndTime.text = showEndTime
        detailsView.showRatingLogo.image = showRatingLogo
        detailsView.showRatingLogo.contentMode = .scaleAspectFill
        
        self.view.addSubview(detailsView)
        
        navigationItem.title = showTitle
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
