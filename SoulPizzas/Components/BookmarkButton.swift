//
//  BookmarkButton.swift
//  SoulPizzas
//
//  Created by Hernan G. Gonzalez on 09/04/2019.
//  Copyright © 2019 Hernan G. Gonzalez. All rights reserved.
//

import UIKit

class BookmarkButton: SpringButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        clipsToBounds = true
        backgroundColor = .pizzaOrange
        aspectRatio(1)
        setImage(UIImage(named: "bookmark"), for: .normal)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        let inset = bounds.width * 0.2
        imageEdgeInsets = .init(top: inset, left: inset, bottom: inset, right: inset)
        layer.cornerRadius = bounds.width / 2
        super.layoutSubviews()
    }
}
