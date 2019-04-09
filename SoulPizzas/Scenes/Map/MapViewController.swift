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

class MapViewController: UIViewController {
    private weak var mapView: GMSMapView!
    private let placeZoomLevel: Float = 16.0
    private let allZoomLevel: Float = 10.0
    private let viewModel = MapViewModel()
    private let disposables = ScopedDisposable(CompositeDisposable())
    private lazy var search = SearchButton(frame: .zero)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Best pizza in town"
        
        let mapView = GMSMapView(frame: .zero)
        view.addSubview(mapView)
        mapView.edgesToSuperview()

        // delegate
        mapView.delegate = self
        self.mapView = mapView
        
        // Bindings
        search.reactive.pressed = CocoaAction(viewModel.refresh)
        search.reactive.inProgress <~ viewModel.refresh.isExecuting
        reactive.updateMarkers <~ viewModel.markers
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        mapView.padding = view.safeAreaInsets
    }
    
    override var navigationItem: UINavigationItem {
        let item = super.navigationItem
        if item.rightBarButtonItem == nil {
            
            let button = UIBarButtonItem(customView: search)
            item.rightBarButtonItem = button
        }
        return item
    }
    
    fileprivate func update(markers: [GMSMarker]) {
        markers.forEach {
            $0.map = self.mapView
        }
        
        let bounds: GMSCoordinateBounds = markers.reduce(.init()) { result, marker in
            return result.includingCoordinate(marker.position)
        }
        
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
        return true
    }
}
