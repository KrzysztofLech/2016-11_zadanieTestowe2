//
//  KreskaCienka1.swift
//  formularz
//
//  Created by Black Thunder on 08.11.2016.
//  Copyright © 2016 Krzysztof Lech. All rights reserved.
//

import UIKit

@IBDesignable class KreskaCienka1: UIView {

    override func draw(_ rect: CGRect) {
        
        let path = UIBezierPath()
        let height = self.bounds.height - 1
        
        path.move(to: CGPoint(
            x: 0,
            y: height))
        path.addLine(to: CGPoint(
            x: self.bounds.width,
            y: height))
        
        path.lineWidth = 1
        #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.2990421661).setStroke()
        
        path.stroke()
    }
}
