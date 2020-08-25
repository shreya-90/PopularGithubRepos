//
//  DownloadService.swift
//  versi-app
//
//  Created by Shreya Pallan on 22/08/20.
//  Copyright © 2020 Shreya Pallan. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireImage

//This is a DownloadService singleton class that is available by all classes till the lifetime of the app
class DownloadService {
    static let instance : DownloadService = DownloadService()
    private init() {}
    
    func downloadTrendingReposDictArray(completion: @escaping (_ reposDictArray : [Dictionary<String,Any>]) -> ()) {
        var trendingRepoArray = [Dictionary<String,Any>]()
        AF.request(trendingRepoUrl).responseJSON { (response) in
            switch response.result {
            case .success(let value):
                
                guard let json = value as? Dictionary<String,Any> else { return }
                guard let jsonDictArray = json["items"] as? [Dictionary<String,Any>] else { return }
                
                for repoDict in jsonDictArray {
                    if trendingRepoArray.count <= 9 {
                        guard  let name = repoDict["name"] as? String,
                               let description = repoDict["description"] as? String,
                               let numberOfForks = repoDict["forks_count"] as? Int,
//                               let language = repoDict["language"] as? String,
                               let contributorsUrl = repoDict["contributors_url"] as? String,
                               let ownerDict = repoDict["owner"] as? Dictionary<String,Any>,
                               let avatarUrl = ownerDict["avatar_url"] as? String,
                            let repoUrl =  repoDict["html_url"] as? String else { print("value not found");break }
                        
                        var language = ""
                        if repoDict["language"] == nil {
                            language = "NA"
                        }
                                
                        let repoDictionary : Dictionary<String,Any> = ["name":name,"description":description,"forks_count":numberOfForks,"language":language,"contributors_url":contributorsUrl,"html_url":repoUrl,"avatar_url":avatarUrl]
                        
                        trendingRepoArray.append(repoDictionary)
                          
                    }
                    else {
                        break
                    }
                }
                completion(trendingRepoArray)
                
                                
            case .failure(let error):
                print(error)
            }
             
        }
       
    }
    
    func downloadTrendingRepos(completion : @escaping (_ reposArray:[Repo]) -> ()){
        var repoArray = [Repo]()
        downloadTrendingReposDictArray { (trendingReposDictArray) in
            
            for dict in trendingReposDictArray {
                //set up each property needed for instance of repo
                 self.downloadTrendingRepo(fromDictionary: dict, completion: { (returnedRepo) in
                    
                    if repoArray.count < 9 {
                        repoArray.append(returnedRepo)
                    }else {
                        let sortedArray = repoArray.sorted { (repoA, repoB) -> Bool in
                            if repoA.numberOfForks > repoB.numberOfForks {
                                return true
                            }
                            else {
                                return false
                            }
                        }
                        completion(repoArray)
                        
                    }
                     
                })
               
            }
            
        }
    }
    
    func downloadTrendingRepo(fromDictionary dict : Dictionary<String,Any>, completion: @escaping (_ repo:Repo) -> ())  {
        
        let avatarUrl =  dict["avatar_url"] as! String
        let name = dict["name"] as! String
        let description = dict["description"] as! String
        let numberOfForks = dict["forks_count"] as! Int
        let language = dict["language"] as! String
        let contributorsUrl = dict["contributors_url"] as! String
        let repoUrl =  dict["html_url"] as! String
        
        self.downloadImageFor(avatarUrl: avatarUrl) { (returnedImage)  in
            self.downloadContributorsDataFor(contributorsUrl: contributorsUrl) { (returnedContributors) in
                 let repo = Repo(image: returnedImage, name: name, description: description, numberOfForks: numberOfForks, language: language, noOfContributors: returnedContributors, repoUrl: repoUrl)
                 return completion(repo)
                
            }
        }
        
      
        
    }
    
    
    func downloadImageFor(avatarUrl:String,  completion: @escaping (_ image:UIImage)->() ) {
        AF.request(avatarUrl).responseImage { (imageReponse) in
            
            switch imageReponse.result {
                case .success(let image):
                    completion(image)
                case .failure(let error):
                    print(error)
                
            }
        }
    }
    
    
    func downloadContributorsDataFor(contributorsUrl:String,completion: @escaping (_ contributors:Int) -> ()){
        AF.request(contributorsUrl).responseJSON{ response in
            
            switch (response.result) {
            case .success(let value):
                guard let json = value as? [Dictionary<String,Any>] else {return}
                if !json.isEmpty {
                    let contributions = json.count
                    completion(contributions)
                }
                
                
            case .failure(let error):
                print(error)
            }
    }
}

}
//escaping closure allows values to be passed in and then to be escaped out to whereever this function is called. So like returning value to a function except that it does it out of a closure
//like a black hole : the input received by the escaping closure function is what gets passed out to the other side


//you cannot normal return out of a closure, you get trapped , you need to use escaping closure
