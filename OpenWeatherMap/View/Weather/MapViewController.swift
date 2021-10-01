//
//  MapViewController.swift
//  OpenWeatherMap
//
//  Created by Andres Marin on 30/09/21.
//

import UIKit
import MapKit

class MapViewController: UIViewController {
    
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var segmentedControl: UISegmentedControl!

    var lat: Double = 0
    var lon: Double = 0
    var tileRenderer: MKTileOverlayRenderer!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let coordenadasRest = CLLocationCoordinate2D(latitude: lat, longitude: lon)
        let region = MKCoordinateRegion.init(center: coordenadasRest, latitudinalMeters: 55000, longitudinalMeters: 55000)
        mapView.setRegion(region, animated: false)
        
        setUpTileRender(typeMap: "temp_new")
        
        mapView.delegate = self
    }
    
    func setUpTileRender(typeMap: String) {
        
        let template = "\(OpenWeatherMap.baseMapURL)/\(typeMap)/{z}/{x}/{y}.png?appid=\(OpenWeatherMap.appid)"
        let overlay = MKTileOverlay(urlTemplate: template)
        overlay.canReplaceMapContent = false
        
        mapView.overlays.forEach {
            if ($0 is MKTileOverlay) {
                self.mapView.removeOverlay($0)
            }
        }
        DispatchQueue.main.async {
            self.mapView.addOverlay(overlay, level: .aboveLabels)
            

        }
        self.tileRenderer = MKTileOverlayRenderer(tileOverlay: overlay)
        
    }
    
    @IBAction func segmentedControl(_ sender: Any) {

        switch segmentedControl.selectedSegmentIndex {
        case 0:
            setUpTileRender(typeMap: "temp_new")
        case 1:
            setUpTileRender(typeMap: "wind_new")
        case 2:
            setUpTileRender(typeMap: "pressure_new")
        case 3:
            setUpTileRender(typeMap: "precipitation_new")
        case 4:
            setUpTileRender(typeMap: "clouds_new")
        default:
            setUpTileRender(typeMap: "temp_new")
        }
    }
    
}

extension MapViewController: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        return tileRenderer
    }
    
}
