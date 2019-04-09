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
        view.addSubview(scroll)
        scroll.edgesToSuperview()
        
        let thumbnail = UIImageView(frame: .zero)
        thumbnail.backgroundColor = .gray
        thumbnail.aspectRatio(1)
        
        let content = [thumbnail].stacked(axis: .vertical)
        scroll.addSubview(content)
        content.widthToSuperview()
    }
}


class UserCollectionView: UICollectionView {
//    convenience init(<#parameters#>) {
//        <#statements#>
//    }
}
