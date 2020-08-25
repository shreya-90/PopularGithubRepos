//
//  RoundedBorderTextField.swift
//  versi-app
//
//  Created by Shreya Pallan on 14/08/20.
//  Copyright © 2020 Shreya Pallan. All rights reserved.
//

import UIKit

class RoundedBorderTextField: UITextField {

    override func awakeFromNib() {
        super.awakeFromNib()
        
        let placeholder = NSAttributedString(string: self.placeholder ?? "", attributes: [NSAttributedString.Key.foregroundColor: #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)])
        attributedPlaceholder = placeholder
        backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        layer.cornerRadius = frame.height/2
        layer.borderColor = #colorLiteral(red: 0.3442408442, green: 0.5524554849, blue: 0.9224796891, alpha: 1)
        layer.borderWidth = 3
        
    }

}
