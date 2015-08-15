//
//  Extension.swift
//  Drank
//
//  Created by Jessica Jiang on 8/14/15.
//  Copyright (c) 2015 Jessica Jiang. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    func circleCrop() {
        self.clipsToBounds = true
        self.layer.cornerRadius = self.frame.width/2.0
    }
}