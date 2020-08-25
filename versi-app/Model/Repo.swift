//
//  Repo.swift
//  versi-app
//
//  Created by Shreya Pallan on 18/08/20.
//  Copyright © 2020 Shreya Pallan. All rights reserved.
//

import Foundation
import UIKit

class Repo {
    public private(set) var image : UIImage
    public private(set) var name : String
    public private(set) var description : String
    public private(set) var numberOfForks : Int
    public private(set) var language : String
    public private(set) var noOfContributors : Int
    public private(set) var repoUrl : String
    
    
    init(image : UIImage, name:String,description : String,numberOfForks : Int,language : String, noOfContributors : Int,repoUrl : String) {
        self.image = image
        self.name = name
        self.description = description
        self.numberOfForks = numberOfForks
        self.language = language
        self.noOfContributors = noOfContributors
        self.repoUrl = repoUrl
    }
}
