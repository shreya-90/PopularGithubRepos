//
//  RoundedBorderButton.swift
//  versi-app
//
//  Created by Shreya Pallan on 14/08/20.
//  Copyright © 2020 Shreya Pallan. All rights reserved.
//

import UIKit

class RoundedBorderButton: UIButton {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = #colorLiteral(red: 0.9999960065, green: 1, blue: 1, alpha: 0)
        self.layer.cornerRadius = frame.height/2
        self.layer.borderWidth = 3
        self.layer.borderColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
    }
}
