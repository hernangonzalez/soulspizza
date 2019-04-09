//
//  ThumbnailView.swift
//  SoulPizzas
//
//  Created by Hernan G. Gonzalez on 09/04/2019.
//  Copyright © 2019 Hernan G. Gonzalez. All rights reserved.
//

import UIKit
import Kingfisher
import ReactiveCocoa

class ThumbnailView: UIImageView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .gray
        clipsToBounds = true
        contentMode = .scaleAspectFill
        kf.indicatorType = .activity
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func load(_ resource: Resource) {
        kf.setImage(with: resource,
                    options: [.transition(.fade(0.3))])
    }
}

extension ThumbnailView: Reusable {
    
    func prepareForReuse() {
        kf.cancelDownloadTask()
        image = nil
    }
}
