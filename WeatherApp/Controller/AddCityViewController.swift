//
//  AddCityViewController.swift
//  WeatherApp
//
//  Created by PMTIOS on 28/03/21.
//

import UIKit
import MapKit

struct Location:Codable {
    var coordinate:Coordinates
    var cityName:String
}

class AddCityViewController: UIViewController,MKMapViewDelegate {
    @IBOutlet weak var mapView:MKMapView!
    lazy var locationManager:CLLocationManager = CLLocationManager()
    var pointAnnotation:MKPointAnnotation?
    var identifier = "marker"
    var selectedLocation:Location?{
        didSet{
            if let location = selectedLocation{
                let coordinate = CLLocationCoordinate2D(latitude: location.coordinate.lat, longitude: location.coordinate.lon)
                addAnnotaion(coordinate: coordinate, title: location.cityName)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerBarBtn()
        mapView.delegate = self
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        mapView.addGestureRecognizer(gestureRecognizer)
        mapView.isZoomEnabled  = true
        currentLocationOnMarker()
    }
    
    func registerBarBtn(){
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(tappedDone))
    }
    
    @IBAction func tappedDone(){
        if let location = selectedLocation{
            let weather = WeatherResponse(coord: location.coordinate,name: location.cityName)
            AccountManager.shared.locations.append(weather)
        }
        navigationController?.popViewController(animated: true)
    }
    
    func currentLocationOnMarker() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
    }
    
    // Gesutre
    @IBAction func handleTap(_ gestureReconizer: UILongPressGestureRecognizer){
        let gestureLocation = gestureReconizer.location(in: mapView)
        let coordinate = mapView.convert(gestureLocation, toCoordinateFrom: mapView)
        locationSelected(coordinate)
    }
    
    func locationSelected(_ coordinate:CLLocationCoordinate2D){
        let location = CLLocation(latitude: coordinate.latitude, longitude: coordinate.longitude)
        CLGeocoder().reverseGeocodeLocation(location, completionHandler: {[weak self] (placemarks, error)->Void in
            
            if (error != nil) {
                debugPrint("Reverse geocoder failed with error" + (error?.localizedDescription)!)
                return
            }
            
            if (placemarks?.count)! > 0 {
                if let pm = placemarks?[0] {
                    let coordinates = Coordinates(lon: coordinate.longitude, lat: coordinate.latitude)
                    self?.selectedLocation = Location(coordinate: coordinates, cityName: pm.locality ?? "")
                }
            } else {
                debugPrint("Problem with the data received from geocoder")
            }
        })
    }
}


// Location Delegate For Current Location
extension AddCityViewController:CLLocationManagerDelegate{
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if  (status == .authorizedAlways || status == .authorizedWhenInUse) {
            locationManager.requestLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("error:: \(error.localizedDescription)")
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let newLocation = locations.first{
            print(newLocation.coordinate.latitude)
            print(newLocation.coordinate.longitude)
            showCurrentLocation(location: newLocation)
        }
    }
    
    func showCurrentLocation(location:CLLocation) {
        let center = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        
        let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1))
        mapView.setRegion(region, animated: true)
        locationSelected(center)
    }
    
}

//Annotation
extension AddCityViewController{
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {

           if annotation is MKPointAnnotation {
               if let annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) {
                   annotationView.annotation = annotation
                annotationView.tintColor = .red
                   return annotationView
               } else {
                let annotationView = MKPinAnnotationView(annotation:annotation, reuseIdentifier:identifier)
                annotationView.isEnabled = true
                annotationView.canShowCallout = true
                annotationView.pinTintColor = .red
                return annotationView
            }
        }

           return nil
    }
    
    func addAnnotaion(coordinate:CLLocationCoordinate2D, title:String = "")  {
        pointAnnotation = MKPointAnnotation()
        pointAnnotation?.coordinate = coordinate
        pointAnnotation?.title = title
        removeAnnotations()
        mapView.addAnnotation(pointAnnotation!)
    }
    
    func removeAnnotations()  {
        mapView.removeAnnotations(mapView.annotations)
    }
}

