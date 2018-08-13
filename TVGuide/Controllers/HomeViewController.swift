//
//  HomeViewController.swift
//  TVGuide
//
//  Created by Rizianne Veluz on 12/08/2018.
//  Copyright © 2018 Rizianne Veluz. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var showsTableView: UITableView!
    
    private var tvShows = [Show]()
    private let showsTableViewCellReuseIdentifier = "TVShowTableViewCell"
    private let showsTableViewCellHeight: CGFloat = 80
    private let homePageTitle = "My shows"
    private let tableViewHeaderTitle = "TONIGHT"
    private let homeToDetailsSegueIdentifier = "homeToDetailsSegue"
    private let loadingIndicator = UIActivityIndicatorView(activityIndicatorStyle: .gray)
    private let tableViewFooterPullOffset: CGFloat = 50

    override func viewDidLoad() {
        super.viewDidLoad()
        fetchMoreShows()

        showsTableView.register(UINib(nibName: "TVShowTableViewCell", bundle: nil), forCellReuseIdentifier: showsTableViewCellReuseIdentifier)
        showsTableView.dataSource = self
        showsTableView.delegate = self
        
        loadingIndicator.frame = CGRect(x:0, y:0, width:showsTableView.frame.size.width, height: showsTableViewCellHeight)
        showsTableView.tableFooterView = loadingIndicator
        showsTableView.tableFooterView?.isHidden = true

        navigationItem.title = homePageTitle
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == homeToDetailsSegueIdentifier {
            let show = tvShows[(showsTableView.indexPathForSelectedRow?.row)!]
            let detailsViewController = segue.destination as! TVShowDetailsViewController
            detailsViewController.showTitle = show.title
            detailsViewController.showStartTime = show.startTime
            detailsViewController.showEndTime = show.endTime
            detailsViewController.showRatingLogo = Show.getIconForRating(show.rating)
        }
    }
    
    @objc private func fetchMoreShows() {
        APIController.getScheduleList(startingAt: tvShows.count) { shows in
            guard let moreShows = shows else {
                DispatchQueue.main.async {
                    self.hideLoadingIndicator()
                }
                return
            }
            self.tvShows.append(contentsOf: moreShows)
            DispatchQueue.main.async {
                self.showsTableView.reloadData()
                self.hideLoadingIndicator()
            }
        }
    }
    
    private func showLoadingIndicator() {
        loadingIndicator.startAnimating()
        showsTableView.tableFooterView?.isHidden = false
    }
    
    private func hideLoadingIndicator() {
        self.loadingIndicator.stopAnimating()
        self.showsTableView.tableFooterView?.isHidden = true
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
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return tableViewHeaderTitle
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return showsTableViewCellHeight
    }
}

extension HomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: homeToDetailsSegueIdentifier, sender: self)
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if scrollView == showsTableView {
            let currentOffset = scrollView.contentOffset.y
            let maximumOffset = scrollView.contentSize.height - scrollView.frame.size.height
            if (maximumOffset - currentOffset) <= tableViewFooterPullOffset {
                showLoadingIndicator()
                fetchMoreShows()
            }
        }
    }
}
