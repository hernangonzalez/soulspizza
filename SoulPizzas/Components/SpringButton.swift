//
//  SpringButton.swift
//  SoulPizzas
//
//  Created by Hernan G. Gonzalez on 09/04/2019.
//  Copyright © 2019 Hernan G. Gonzalez. All rights reserved.
//

import UIKit

class SpringButton: UIButton {
    static let duration: TimeInterval = 0.7
    static let transform: CGAffineTransform = CGAffineTransform(scaleX: 0.9, y: 0.9)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        adjustsImageWhenDisabled = false
        showsTouchWhenHighlighted = false
        reversesTitleShadowWhenHighlighted = false
        
        addTarget(self, action: #selector(animatePressDown(sender:)), for: .touchDown)
        addTarget(self, action: #selector(animatePressUp(sender:)), for: .touchUpInside)
        addTarget(self, action: #selector(animatePressUp(sender:)), for: .touchUpOutside)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var isHighlighted: Bool {
        get {
            return super.isHighlighted
        }
        set { }
    }
    
    @objc
    private func animatePressDown(sender: SpringButton) {
        guard transform == .identity else  {
            return
        }
        
        animate.spring(SpringButton.duration) {
            $0.transform = SpringButton.transform
        }
    }
    
    @objc
    private func animatePressUp(sender: SpringButton) {
        guard transform != .identity else  {
            return
        }
        
        animate.spring(SpringButton.duration) {
            $0.transform = .identity
        }
    }
}
