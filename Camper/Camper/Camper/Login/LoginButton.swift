//
//  LoginButton.swift
//  Camper
//
//  Created by Ertheo Siswadi on 9/14/18.
//  Copyright © 2018 Ertheo Siswadi. All rights reserved.
//

import Foundation
import UIKit

class LoginButton : UIButton
{
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.backgroundColor = UIColor(displayP3Red: 31/255, green: 75/255, blue: 164/255, alpha: 1)
        self.layer.cornerRadius = 13.0
        self.tintColor = UIColor.white
        self.titleLabel?.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 14)
        
    }
}
