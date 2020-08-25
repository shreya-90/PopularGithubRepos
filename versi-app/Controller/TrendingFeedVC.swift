//
//  TrendingFeedVC.swift
//  versi-app
//
//  Created by Shreya Pallan on 14/08/20.
//  Copyright © 2020 Shreya Pallan. All rights reserved.
//

import Foundation



import UIKit

class TrendingFeedVC: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    

    @IBOutlet weak var tableView: UITableView!
    
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.reloadData()
        DownloadService.instance.downloadTrendingRepos { (reposArray) in
            print("\(reposArray[0].name)")
              print("\(reposArray[0].numberOfForks)")
            print("\(reposArray[1].name)")
                         print("\(reposArray[1].numberOfForks)")

        }
//        DownloadService.instance.downloadTrendingReposDictArray { (dictArray) in
//            print(dictArray)
//        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "trendingRepoCell",for: indexPath) as? TrendingRepoCell
            else {
                return UITableViewCell()
            }
        
        let repo = Repo(image: UIImage(named: "searchIconLarge")!, name: "SWIFT", description: "Apple Programming Language", numberOfForks: 563, language: "Swift", noOfContributors: 1002, repoUrl: "www.google.com")
        cell.configureCell(repo: repo)
        return cell
    }


}

