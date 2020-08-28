//
//  TrendingFeedVC.swift
//  versi-app
//
//  Created by Shreya Pallan on 14/08/20.
//  Copyright © 2020 Shreya Pallan. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

import UIKit

class TrendingFeedVC: UIViewController {
    
    

    @IBOutlet weak var tableView: UITableView!
    let refreshControl = UIRefreshControl()
    
    
    var disposeBag = DisposeBag()
    var publishSubject = PublishSubject<[Repo]>()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.refreshControl = refreshControl
        refreshControl.tintColor = #colorLiteral(red: 0.3442408442, green: 0.5524554849, blue: 0.9224796891, alpha: 1)
        refreshControl.attributedTitle = NSAttributedString(string: "Fetching Hot Github Repos 🔥", attributes: [NSAttributedString.Key.foregroundColor : #colorLiteral(red: 0.3442408442, green: 0.5524554849, blue: 0.9224796891, alpha: 1), NSAttributedString.Key.font : UIFont(name: "AvenirNext-DemiBold", size: 16)!])
        refreshControl.addTarget(fetchData(), action: #selector(fetchData), for: .valueChanged)
        
        fetchData()
        
        publishSubject.bind(to: tableView.rx.items(cellIdentifier: "trendingRepoCell")){
            (row,repo:Repo,cell:TrendingRepoCell) in
            print(repo.name)
            cell.configureCell(repo: repo)
        }
        .disposed(by: disposeBag)

    }
    
    @objc func fetchData(){
        DownloadService.instance.downloadTrendingRepos { (repoArray) in
            self.publishSubject.onNext(repoArray)
            self.refreshControl.endRefreshing()
        }
    }
}

