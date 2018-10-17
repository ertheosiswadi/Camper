//
//  LoginTextField.swift
//  Camper
//
//  Created by Ertheo Siswadi on 9/14/18.
//  Copyright © 2018 Ertheo Siswadi. All rights reserved.
//

import Foundation
import UIKit
import QuartzCore

class LoginTextField : UITextField
{
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.layer.borderColor = UIColor(red:1.00, green:0.73, blue:0.00, alpha:1.0).cgColor
        self.layer.borderWidth = 0.5
        self.layer.cornerRadius = 4.0
    }
}
