//
//  UserThumbnailCell.swift
//  SoulPizzas
//
//  Created by Hernan G. Gonzalez on 09/04/2019.
//  Copyright © 2019 Hernan G. Gonzalez. All rights reserved.
//

import UIKit

class UserThumbnailCell: UICollectionViewCell {
    private weak var thumbnail: ThumbnailView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        let view = ThumbnailView(frame: .zero)
        contentView.addSubview(view)
        view.edgesToSuperview()
        thumbnail = view
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        thumbnail.layer.cornerRadius = bounds.width / 2
        super.layoutSubviews()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        thumbnail.prepareForReuse()
    }
    
    func render(_ avatar: URL) {
        thumbnail.load(avatar)
    }
}

