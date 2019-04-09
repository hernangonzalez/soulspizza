//
//  Animatable.swift
//  SoulPizzas
//
//  Created by Hernan G. Gonzalez on 09/04/2019.
//  Copyright © 2019 Hernan G. Gonzalez. All rights reserved.
//

import UIKit

// MARK: Animatable
protocol Animatable { }

extension Animatable {
    public var animate: Animate<Self> {
        return Animate(self)
    }
}

struct Animate<Base> {
    typealias AnimationBlock = (Base) -> Void
    public let base: Base
    public var damping: CGFloat = 0.4
    public var spring: CGFloat = 0.7
    public var endsAt: TimeInterval = 0
    
    fileprivate init(_ base: Base) {
        self.base = base
    }
}

// Animations
extension Animate where Base: UIView {
    
    /**
     CurveEaseInOut
     */
    func linear(_ duration: TimeInterval, block: @escaping AnimationBlock, completion: @escaping AnimationBlock) {
        let view = base
        let animations = {
            block(view)
            view.layoutIfNeeded()
        }
        
        UIView.animate(withDuration: duration,
                       delay: 0,
                       options: [.curveEaseInOut],
                       animations: animations,
                       completion: { _ in completion(view) })
    }
    
    func linear(_ duration: TimeInterval = 0.35, block: @escaping AnimationBlock) {
        linear(duration, block: block, completion: { _ in })
    }
    
    /**
     Spring
     Will go over de limits and back.
     */
    func spring(_ duration: TimeInterval = 0.35, delay: TimeInterval = 0, block: @escaping AnimationBlock) {
        let view = base
        let animations = {
            block(view)
            view.layoutIfNeeded()
        }
        
        UIView.animate(withDuration: duration,
                       delay: delay,
                       usingSpringWithDamping: damping,
                       initialSpringVelocity: spring,
                       options: [.curveEaseInOut],
                       animations: animations)
    }
}

// MARK: UIView
extension UIView: Animatable { }
