//
//  BookPlaceView.swift
//  SoulPizzas
//
//  Created by Hernan G. Gonzalez on 09/04/2019.
//  Copyright © 2019 Hernan G. Gonzalez. All rights reserved.
//

import UIKit

class BookPlaceView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let line = UIView(frame: .zero)
        line.backgroundColor = .lightGray
        line.height(0.5)
        
        let button = SpringButton(frame: .zero)
        button.backgroundColor = .pizzaOrange
        button.layer.cornerRadius = 4
        button.clipsToBounds = true
        button.setTitle("Book now", for: .normal)
        button.addTarget(self, action: #selector(bookNow), for: .touchUpInside)
        button.contentEdgeInsets = .init(top: 10, left: 12, bottom: 10, right: 12)
        
        addSubview(line)
        addSubview(button)
        button.centerInSuperview()
        line.edgesToSuperview(excluding: .bottom)
        
        height(84)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc
    private func bookNow() {
        let url = URL(string: "http://www.booking.com")!
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
}
