//
//  UIViewcontroller+Extension.swift
//  versi-app
//
//  Created by Shreya Pallan on 28/08/20.
//  Copyright © 2020 Shreya Pallan. All rights reserved.
//

import UIKit
import SafariServices

extension UIViewController{
    
    func presentSFSafariForVC(url:String) {
        let readmeUrl = URL(string: url + readmeSegment)
        let safariVc = SFSafariViewController(url: readmeUrl!)
        present(safariVc, animated: true, completion: nil)
        
    }
}
