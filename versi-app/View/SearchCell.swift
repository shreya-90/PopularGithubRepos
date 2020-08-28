//
//  SearchCell.swift
//  versi-app
//
//  Created by Shreya Pallan on 27/08/20.
//  Copyright © 2020 Shreya Pallan. All rights reserved.
//

import UIKit

class SearchCell: UITableViewCell {

    @IBOutlet weak var repoNameLbl: UILabel!
    
    @IBOutlet weak var repoDescLbl: UILabel!
    
    @IBOutlet weak var forksCountLbl: UILabel!
    
    @IBOutlet weak var languageLbl: UILabel!
    
    @IBOutlet weak var backView: UIView!
    
    public private(set) var repoUrl : String?
    
    func configureCell(repo:Repo){
        repoNameLbl.text = repo.name
        repoDescLbl.text = repo.description
        forksCountLbl.text = "\(repo.numberOfForks)"
        languageLbl.text = repo.language
        repoUrl = repo.repoUrl
        
        print("configuring searchcell")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        backView.layer.cornerRadius = 15
        
    }

    

}
