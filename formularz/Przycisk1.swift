//
//  Przycisk1.swift
//  formularz
//
//  Created by Black Thunder on 09.11.2016.
//  Copyright © 2016 Krzysztof Lech. All rights reserved.
//

import UIKit

class Przycisk1: UIButton {
    
    override func draw(_ rect: CGRect) {
        
        let translation: CGFloat = 700
        center.x += translation
        
        UIView.animate(
            withDuration: 2.0,
            delay: 1.0,
            usingSpringWithDamping: 0.5,
            initialSpringVelocity: 0.0,
            options: [.curveEaseOut],
            animations: {
                self.center.x -= translation
            },
            completion: nil)
    }    
}
