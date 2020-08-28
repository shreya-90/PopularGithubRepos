//
//  SearchVC.swift
//  versi-app
//
//  Created by Shreya Pallan on 14/08/20.
//  Copyright © 2020 Shreya Pallan. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import Alamofire

class SearchVC: UIViewController {

    @IBOutlet weak var searchField: RoundedBorderTextField!
    @IBOutlet weak var tableView: UITableView!
    
    var disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindElements()
        tableView.rx.setDelegate(self)
    }
    
    
    func bindElements(){
        //bind search field to table view
        
        //typing query in search field .. emit observables of Array of Repo
        //So Search field is the Observable/ Emitter
        //need to display reults generated in table view by binding it to tableview
        
        let searchResultsObservable = self.searchField.rx.text
            .orEmpty
            .debounce(.milliseconds(500), scheduler: MainScheduler.instance)
            .map {
                $0.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed) ?? ""
            }
            .flatMap { (query) -> Observable<[Repo]> in
                if query == "" {
                    return Observable<[Repo]>.just([])
                } else {
                    let url = searchUrl + query + starDescendingSegment
                    var searchRepos = [Repo]()
                    
                    return URLSession.shared.rx.json(url: URL(string: url)!).map {
                        print(url)
                        let results = $0 as AnyObject
                        let items = results.object(forKey: "items") as? [Dictionary<String,Any>] ?? []
                        
                        for dict in items {
                            guard   let name = dict["name"] as? String,
                                    let description = dict["description"] as? String,
                                    let numberOfForks = dict["forks_count"] as? Int,
                                    let repoURL = dict["html_url"] as? String else  { break }
                                    var language = ""
                                    if dict["language"] == nil {
                                        language = "NA"
                                    }
                                    
                            let repo = Repo(image: UIImage(named: "searchIconLarge")!, name: name, description: description, numberOfForks: numberOfForks, language: language, noOfContributors: 0, repoUrl: repoURL)
                            
                            searchRepos.append(repo)
                            print(repo.name)
                        }
                        print(searchRepos)
                       return searchRepos
                        
                    }
                    
                }

            }
        .observeOn(MainScheduler.instance)
        
        searchResultsObservable.bind(to: tableView.rx.items(cellIdentifier: "searchCell")) { (row, repo: Repo, cell: SearchCell) in
        cell.configureCell(repo: repo)
        }
        .addDisposableTo(disposeBag)
    }
    

}

extension SearchVC: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) as? SearchCell else {return}
        print(cell.repoUrl)
        self.presentSFSafariForVC(url: cell.repoUrl!)
        
    }
    
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        view.endEditing(true)
    }
}


extension SearchVC : UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
        return true
    }
}
