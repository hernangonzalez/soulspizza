//
//  PlaceInfoView.swift
//  SoulPizzas
//
//  Created by Hernan G. Gonzalez on 10/04/2019.
//  Copyright © 2019 Hernan G. Gonzalez. All rights reserved.
//

import UIKit
import Cosmos

class PlaceInfoView: UIView {
    private weak var address: UILabel!
    private weak var action: BookmarkButton!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let label = UILabel(frame: .zero)
        label.textColor = .lightGray
        label.numberOfLines = 2
        
        let settings = CosmosSettings()
        let rating = CosmosView(settings: settings)
        rating.rating = 4
        
        let bookmark = BookmarkButton(frame: .zero)
        bookmark.width(60)

        let left = [label, rating].stacked(axis: .vertical)
        left.spacing = 2
        let stack = [left, bookmark].stacked()
        stack.spacing = 8
        stack.alignment = .top
        addSubview(stack)
        stack.edgesToSuperview(insets: .init(top: 4, left: 8, bottom: 4, right: 8))
        address = label
        action = bookmark
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func update(_ place: PlaceViewModel) {
        address.text = place.address
    }
}
