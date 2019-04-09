//
//  SearchButton.swift
//  SoulPizzas
//
//  Created by Hernan G. Gonzalez on 09/04/2019.
//  Copyright © 2019 Hernan G. Gonzalez. All rights reserved.
//

import UIKit
import ReactiveSwift

class SearchButton: UIButton {
    private weak var activity: UIActivityIndicatorView?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setContentCompressionResistancePriority(.required, for: .horizontal)
        setContentCompressionResistancePriority(.required, for: .vertical)
        setImage(UIImage(named: "search"), for: .normal)
        contentEdgeInsets = .init(top: 8, left: 8, bottom: 8, right: 8)
        aspectRatio(1)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: Progress
fileprivate extension SearchButton {
 
    func startAnimation() {
        isUserInteractionEnabled = false
        setImage(nil, for: .normal)
        
        let activity = UIActivityIndicatorView(style: .gray)
        activity.hidesWhenStopped = true
        activity.startAnimating()
        addSubview(activity)
        activity.edgesToSuperview()
        self.activity = activity
    }
    
    func stopAnimation() {
        isUserInteractionEnabled = true
        setImage(UIImage(named: "search"), for: .normal)
        activity?.stopAnimating()
        activity?.removeFromSuperview()
    }
}

// MARK: Reactive
extension Reactive where Base: SearchButton {
    
    var inProgress: BindingTarget<Bool> {
        return makeBindingTarget { base, active in
            if active {
                base.startAnimation()
            } else {
                base.stopAnimation()
            }
        }
    }
}

