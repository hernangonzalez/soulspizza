//
//  UserCollectionView.swift
//  SoulPizzas
//
//  Created by Hernan G. Gonzalez on 09/04/2019.
//  Copyright © 2019 Hernan G. Gonzalez. All rights reserved.
//

import UIKit
import ReactiveCocoa
import ReactiveSwift

class UserCollectionView: UICollectionView {
    private let viewModel: UserCollectionViewModel
    
    init(_ model: UserCollectionViewModel) {
        viewModel = model
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.sectionInset = .init(top: 4, left: 8, bottom: 4, right: 8)
        super.init(frame: .zero, collectionViewLayout: layout)
        register(UserThumbnailCell.self)
        backgroundColor = .white
        dataSource = self
        
        reactive.reloadData <~ model.reload
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: UICollectionViewDataSource
extension UserCollectionView: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.loadCell(for: indexPath) as UserThumbnailCell
        let avatar = viewModel.media(at: indexPath.item)
        cell.render(avatar)
        return cell
    }
}
