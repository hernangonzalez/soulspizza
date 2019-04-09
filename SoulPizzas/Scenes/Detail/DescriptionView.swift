//
//  DescriptionView.swift
//  SoulPizzas
//
//  Created by Hernan G. Gonzalez on 09/04/2019.
//  Copyright © 2019 Hernan G. Gonzalez. All rights reserved.
//

import UIKit
import TinyConstraints

class DescriptionView: UIView {
    private weak var action: UIButton!
    private var textHeight: Constraints = []
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        clipsToBounds = true
        
        let text = UILabel(frame: .zero)
        text.numberOfLines = 0
        text.textColor = .darkText
        text.text = "Google Maps began as a C++ desktop program at Where 2 Technologies. In October 2004, the company was acquired by Google, which converted it into a web application. After additional acquisitions of a geospatial data visualization company and a realtime traffic analyzer, Google Maps was launched in February 2005.[1] The service's front end utilizes JavaScript, XML, and Ajax. Google Maps offers an API that allows maps to be embedded on third-party websites,[2] and offers a locator for businesses and other organizations in numerous countries around the world. Google Map Maker allowed users to collaboratively expand and update the service's mapping worldwide but was discontinued from March 2017. However, crowdsourced contributions to Google Maps were not discontinued as the company announced those features will be transferred to the Google Local Guides program.[3]"
        
        let button = UIButton(type: .custom)
        button.setTitleColor(.pizzaOrange, for: .normal)
        button.setTitle("Read more", for: .normal)
        button.contentHorizontalAlignment = .left
        button.addTarget(self, action: #selector(toggleExpand), for: .touchUpInside)
        
        let stack = [text, button].stacked(axis: .vertical)
        stack.spacing = 4
        addSubview(stack)
        stack.edgesToSuperview(insets: .init(top: 4, left: 8, bottom: 4, right: 8))
        
        action = button
        textHeight = text.height(max: 120)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc
    private func toggleExpand() {
        if textHeight.isActive {
            action.setTitle("Read less", for: .normal)
            textHeight.deActivate()
        } else {
            action.setTitle("Read more", for: .normal)
            textHeight.activate()
        }
        
        window?.animate.linear(0.25) {
            $0.layoutIfNeeded()
        }
    }
}

extension Constraints {
    
    var isActive: Bool {
        return reduce(true) {
            $0 && $1.isActive
        }
    }
}

