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
    
    var disposeBag = DisposeBag()
    var publishSubject = PublishSubject<[Repo]>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchData()
        
        publishSubject.bind(to: tableView.rx.items(cellIdentifier: "trendingRepoCell")){
            (row,repo:Repo,cell:TrendingRepoCell) in
            cell.configureCell(repo: repo)
        }
        .disposed(by: disposeBag)

    }
    
    func fetchData(){
        DownloadService.instance.downloadTrendingRepos { (repoArray) in
            self.publishSubject.onNext(repoArray)
        }
    }
}

