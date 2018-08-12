//
//  HomeViewController.swift
//  TVGuide
//
//  Created by Xhan on 12/08/2018.
//  Copyright © 2018 Rizianne Veluz. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var showsTableView: UITableView!
    
    var tvShows = [Show]()
    let showsTableViewCellReuseIdentifier = "TVShowTableViewCell"
    let showsTableViewCellHeight: CGFloat = 80
    let homePageTitle = "My shows"

    override func viewDidLoad() {
        super.viewDidLoad()
        
        APIController.getSchedule() { shows in
            self.tvShows = shows
            DispatchQueue.main.async {
                self.showsTableView.reloadData()
            }
        }

        showsTableView.register(UINib(nibName: "TVShowTableViewCell", bundle: nil), forCellReuseIdentifier: showsTableViewCellReuseIdentifier)
        showsTableView.dataSource = self
        showsTableView.delegate = self

        navigationItem.title = homePageTitle
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tvShows.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = showsTableView.dequeueReusableCell(withIdentifier: showsTableViewCellReuseIdentifier, for: indexPath) as! TVShowTableViewCell
        let show = tvShows[indexPath.row]
        cell.showTitle.text = show.title
        cell.showStartTime.text = show.startTime
        cell.showEndTime.text = show.endTime
        cell.channelLogo.image = Show.getIconForChannel(show.channel)
        cell.showRatingLogo.image = Show.getIconForRating(show.rating)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return showsTableViewCellHeight
    }
}

extension HomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}
