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
    
    let showsTableViewCellReuseIdentifier = "TVShowTableViewCell"

    override func viewDidLoad() {
        super.viewDidLoad()
        
        showsTableView.register(UINib(nibName: "TVShowTableViewCell", bundle: nil), forCellReuseIdentifier: showsTableViewCellReuseIdentifier)
        showsTableView.dataSource = self
        showsTableView.delegate = self

        navigationItem.title = "My shows"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = showsTableView.dequeueReusableCell(withIdentifier: showsTableViewCellReuseIdentifier, for: indexPath) as! TVShowTableViewCell
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
}

extension HomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}
