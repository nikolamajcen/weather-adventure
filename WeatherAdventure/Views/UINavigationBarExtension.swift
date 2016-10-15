//
//  UINavigationBarExtension.swift
//  WeatherAdventure
//
//  Created by Nikola Majcen on 25/08/16.
//  Copyright © 2016 Nikola Majcen. All rights reserved.
//

import UIKit

extension UINavigationBar {
    
    func showBorderLine() {
        findBorderLine().isHidden = false
    }
    
    func hideBorderLine() {
        findBorderLine().isHidden = true
    }
    
    fileprivate func findBorderLine() -> UIImageView! {
        return self.subviews
            .flatMap { $0.subviews }
            .flatMap { $0 as? UIImageView }
            .filter { $0.bounds.size.width == self.bounds.size.width }
            .filter { $0.bounds.size.height <= 2 }
            .first
    }
}
