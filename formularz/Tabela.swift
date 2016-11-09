//
//  Tabela.swift
//  formularz
//
//  Created by Black Thunder on 09.11.2016.
//  Copyright © 2016 Krzysztof Lech. All rights reserved.
//

import UIKit

class Tabela: UITableView {

    override func draw(_ rect: CGRect) {
        
        let tableWidth = bounds.size.width
        let translation = tableWidth * 1.5
        
        center.x -= translation
        
        UIView.animate(
            withDuration: 2.0,
            delay: 1.0,
            usingSpringWithDamping: 0.5,
            initialSpringVelocity: 0.0,
            options: [.curveEaseOut],
            animations: {
                self.center.x += translation
            }, completion: { _ in
                
                let round = CABasicAnimation(keyPath: "cornerRadius")
                round.fromValue = self.layer.cornerRadius
                round.toValue = 20.0
                round.duration = 0.3
                self.layer.add(round, forKey: nil)
                self.layer.cornerRadius = 20.0
            })
    }
}
