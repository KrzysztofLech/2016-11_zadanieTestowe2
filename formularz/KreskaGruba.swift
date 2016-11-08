//
//  KreskaGruba.swift
//  formularz
//
//  Created by Black Thunder on 08.11.2016.
//  Copyright © 2016 Krzysztof Lech. All rights reserved.
//

import UIKit

@IBDesignable class KreskaGruba: UIView {

    override func draw(_ rect: CGRect) {
        
        let path = UIBezierPath()
        let height = self.bounds.height - 2
        
        path.move(to: CGPoint(
            x: 0,
            y: height))
        path.addLine(to: CGPoint(
            x: self.bounds.width,
            y: height))
        
        path.lineWidth = 3
        #colorLiteral(red: 0, green: 0.8941176471, blue: 0.5725490196, alpha: 1).setStroke()
        
        path.stroke()
    }
}
