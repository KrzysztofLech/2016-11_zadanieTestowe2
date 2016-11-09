//
//  Kolo.swift
//  formularz
//
//  Created by Black Thunder on 09.11.2016.
//  Copyright © 2016 Krzysztof Lech. All rights reserved.
//

import UIKit

@IBDesignable class Kolo: UIButton {

    override func draw(_ rect: CGRect) {
        let path = UIBezierPath(ovalIn: CGRect(
            x: rect.origin.x + 2,
            y: rect.origin.y + 2,
            width: rect.width - 4,
            height: rect.height - 4))
        path.lineWidth = 2
        #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.1961151541).setStroke()
        path.stroke()
    }
}
