//
//  MapViewController.swift
//  SoulPizzas
//
//  Created by Hernan G. Gonzalez on 08/04/2019.
//  Copyright © 2019 Hernan G. Gonzalez. All rights reserved.
//

import UIKit
import GoogleMaps
import TinyConstraints
import ReactiveCocoa
import ReactiveSwift
import Kingfisher

class MapViewController: UIViewController {
    private weak var mapView: GMSMapView!
    private let placeZoomLevel: Float = 16.0
    private let allZoomLevel: Float = 10.0
    private let viewModel: MapViewModel
    private let disposables = ScopedDisposable(CompositeDisposable())
    private lazy var search = SearchButton(frame: .zero)
    private var firstLoad = false
    
    init(_ model: MapViewModel) {
        viewModel = model
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let mapView = GMSMapView(frame: .zero)
        view.addSubview(mapView)
        mapView.edgesToSuperview()

        // delegate
        mapView.delegate = self
        self.mapView = mapView
        
        // Bindings
        search.reactive.pressed = CocoaAction(viewModel.refresh)
        disposables += search.reactive.inProgress <~ viewModel.refresh.isExecuting
        disposables += reactive.updateMarkers <~ viewModel.markers
        disposables += reactive.presentError <~ viewModel.error
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        mapView.padding = view.safeAreaInsets
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if !firstLoad {
            disposables += viewModel.refresh
                .apply()
                .start()
            firstLoad = true
        }
    }
    
    override var navigationItem: UINavigationItem {
        let item = super.navigationItem
        item.title = viewModel.title
        
        if item.rightBarButtonItem == nil {
            let button = UIBarButtonItem(customView: search)
            item.rightBarButtonItem = button
        }
        
        if item.backBarButtonItem == nil {
            item.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        }
        
        return item
    }
    
    fileprivate func update(markers: [Marker]) {
        // Remove previous results
        mapView.clear()
        
        // Assing results to map
        markers.forEach {
            $0.map = self.mapView
        }
        
        // Prefetch thumbnails
        let resources = markers.compactMap { $0.thumbnail }
        let prefetcher = ImagePrefetcher(resources: resources)
        prefetcher.start()
        
        // Resolve map bound
        let bounds: GMSCoordinateBounds = markers.reduce(.init()) { result, marker in
            return result.includingCoordinate(marker.position)
        }
        
        // Focus on results
        if bounds.isValid {
            let camera = GMSCameraUpdate.fit(bounds)
            mapView.animate(with: camera)
        }
    }
}

// MARK: Reactive
extension Reactive where Base: MapViewController {
    
    var updateMarkers: BindingTarget<[Marker]> {
        return makeBindingTarget { base, markers in
            base.update(markers: markers)
        }
    }
}

// MARK: GMSMapViewDelegate
extension MapViewController: GMSMapViewDelegate {
    
    func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool {
        let position = GMSCameraPosition(target: marker.position, zoom: placeZoomLevel)
        let update = GMSCameraUpdate.setCamera(position)
        mapView.animate(with: update)
        
        if let detail = viewModel.detail(with: marker) {
            let router = PlaceDetailRouter(navigation: navigationController)
            router.route(detail)
            return true
        }

        return false
    }
}
