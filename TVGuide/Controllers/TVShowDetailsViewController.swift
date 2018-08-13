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
        detailsView.frame = self.view.safeAreaLayoutGuide.layoutFrame;

        detailsView.showTitle.text = showTitle
        detailsView.showStartTime.text = showStartTime
        detailsView.showEndTime.text = showEndTime
        detailsView.showRatingLogo.image = showRatingLogo
        
        APIController.getExtraDetailsForShow(showTitle!) { data in
            guard let details = data else {
                return
            }
            
            let url = URL.init(string: details.poster)
            APIController.getImageFromUrl(url!) { data in
                guard let fetchedData = data else {
                    return
                }
                
                DispatchQueue.main.async {
                    detailsView.showPoster.image = UIImage.init(data: fetchedData)
                    detailsView.showPoster.alpha = 0.5
                }
            }

            DispatchQueue.main.async {
                detailsView.summary.text = details.plot
            }
        }
        self.view.addSubview(detailsView)
        
        navigationItem.title = showTitle
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
