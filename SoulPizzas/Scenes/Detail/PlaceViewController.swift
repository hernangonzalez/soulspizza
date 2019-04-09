//
//  PlaceViewController.swift
//  SoulPizzas
//
//  Created by Hernan G. Gonzalez on 09/04/2019.
//  Copyright © 2019 Hernan G. Gonzalez. All rights reserved.
//

import UIKit

class PlaceViewController: UIViewController {
    private let viewModel: PlaceViewModel
    private weak var collection: UICollectionView!
    
    init(_ model: PlaceViewModel) {
        viewModel = model
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var navigationItem: UINavigationItem {
        let item = super.navigationItem
        item.title = viewModel.name
        return item
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        let scroll = UIScrollView(frame: .zero)
        scroll.alwaysBounceVertical = true
        scroll.bounces = true
        view.addSubview(scroll)
        scroll.edgesToSuperview()
        
        let thumbnail = UIImageView(frame: .zero)
        thumbnail.backgroundColor = .gray
        thumbnail.aspectRatio(1)
        thumbnail.kf.indicatorType = .activity
        thumbnail.kf.setImage(with: viewModel.thumbnail, options: [.transition(.fade(0.3))])
        
        let users = UserCollectionView(viewModel.friends)
        users.height(60)
        
        let description = DescriptionView(frame: .zero)
        
        let content = [thumbnail, users, description].stacked(axis: .vertical)
        content.spacing = 12
        scroll.addSubview(content)
        content.width(to: view)
        content.topToSuperview()
        content.bottomToSuperview()
    }
}

