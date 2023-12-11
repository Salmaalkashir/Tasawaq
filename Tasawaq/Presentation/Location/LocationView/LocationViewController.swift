//
//  AddressViewController.swift
//  Tasawaq
//
//  Created by Salma on 07/12/2023.
//

import UIKit
import MapKit
import CoreLocation

class LocationViewController: UIViewController {
  //MARK: -IBoutlets
  @IBOutlet weak var mapView: MKMapView!
  @IBOutlet weak var subView: UIView!
  @IBOutlet weak var userLocation: UILabel!
  @IBOutlet weak var pinLocation: UIImageView!
  @IBOutlet weak var searchTextField: UITextField!

  var locationViewModel = LocationViewModel()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    configureView()
    let initLocation = CLLocation(latitude: 30.06863, longitude: 31.24967)
    setStartingLocation(location: initLocation, distance: 400000)
    configureMap()
    checkLocationService()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    pinLocation.isHidden = true
    userLocation.isHidden = true
    navigationController?.isNavigationBarHidden = true
  }
  
  func configureView(){
    subView.layer.cornerRadius = 20
    subView.backgroundColor = .white
    subView.layer.shadowOffset = CGSize(width: 5, height: 5)
    subView.layer.shadowRadius = 5
    subView.layer.shadowOpacity = 0.5
  }
  
  func configureMap(){
    locationViewModel.locationManager.delegate = self
    locationViewModel.locationManager.desiredAccuracy = kCLLocationAccuracyBest
  }
  //MARK: -SettingUpMap
  func setStartingLocation(location: CLLocation, distance: CLLocationDistance){
    let region = MKCoordinateRegion(center: location.coordinate , latitudinalMeters: distance, longitudinalMeters: distance)
    mapView.setRegion(region, animated: true)
    mapView.setCameraBoundary(MKMapView.CameraBoundary(coordinateRegion: region), animated: true)
    let zoomRange = MKMapView.CameraZoomRange(maxCenterCoordinateDistance: 700000)
    mapView.setCameraZoomRange(zoomRange, animated: true)
  }
  
  func checkLocationService(){
    DispatchQueue.global(qos: .background).async {
      if CLLocationManager.locationServicesEnabled(){
        self.checkAuthorization()
      }else{
        self.showAlert(message: "Please enable location servie")
      }
    }
  }
  
  func checkAuthorization(){
    switch locationViewModel.locationManager.authorizationStatus{
    case .authorizedWhenInUse:
      locationViewModel.locationManager.startUpdatingLocation()
    case .notDetermined:
      locationViewModel.locationManager.requestWhenInUseAuthorization()
    case .authorizedAlways:
      locationViewModel.locationManager.startUpdatingLocation()
    case .denied:
      showAlert(message: "Please allow access to location")
    case .restricted:
      showAlert(message: "Authorization restricted")
    default:
      break
    }
  }
  
  func zoomToUserLocation(location: CLLocation){
    let region = MKCoordinateRegion(center: location.coordinate, latitudinalMeters: 500, longitudinalMeters: 500)
    mapView.setRegion(region, animated: true)
    
    let geoCoder = CLGeocoder()
    geoCoder.reverseGeocodeLocation(location) { places, error in
      guard let place = places?.first , error == nil else{return}
      self.userLocation.text = "\(place.name ?? "no name"),\(place.subLocality ?? "no subloc") ,\(place.administrativeArea ?? "no admin")"
      
      let pin = MKPointAnnotation()
      pin.coordinate = location.coordinate
      pin.title = "\(place.name ?? "")"
      pin.subtitle = "\(place.subLocality ?? "")"
      self.mapView.addAnnotation(pin)
      self.locationViewModel.userAnnotation = pin
      self.mapView.removeAnnotation(self.locationViewModel.searchAnnotation ?? MKPointAnnotation())
    }
    
  }
  
  func searchForDestination(destination: String){
    let geoCoder = CLGeocoder()
    geoCoder.geocodeAddressString(destination) { places, error in
      guard let place = places?.first, error == nil else{
        let alert = UIAlertController(title: "Alert", message: "Invalid Destination", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .destructive))
        self.present(alert, animated: true)
        return
      }
      guard let location = place.location else {return}
      
      if let existingAnnotation = self.locationViewModel.searchAnnotation{
        self.mapView.removeAnnotation(existingAnnotation)
      }
      
      let region = MKCoordinateRegion(center: location.coordinate, latitudinalMeters: 1000, longitudinalMeters: 1000)
      self.mapView.setRegion(region, animated: true)
      self.searchTextField.text = " "
      geoCoder.reverseGeocodeLocation(location) { places, error in
        guard let place = places?.first , error == nil else{return}
        
        let newAnnotation = MKPointAnnotation()
        newAnnotation.coordinate = location.coordinate
        newAnnotation.title = "\(place.name ?? "no name")"
        newAnnotation.subtitle = "\(place.locality ?? "no loc")"
        self.mapView.addAnnotation(newAnnotation)
        self.mapView.removeAnnotation(self.locationViewModel.userAnnotation ?? MKPointAnnotation())
        self.locationViewModel.searchAnnotation = newAnnotation
        self.userLocation.text = "\(place.name ?? "no name"),\(place.subLocality ?? "no subloc") ,\(place.administrativeArea ?? "no admin")"
      }
    }
  }
  
  func getLocationInfo(location: CLLocation){
    let geoCoder = CLGeocoder()
    geoCoder.reverseGeocodeLocation(location) { places, error in
      guard let place = places?.first , error == nil else{return}
      self.userLocation.text = "\(place.name ?? "no name"),\(place.subLocality ?? "no subloc") ,\(place.administrativeArea ?? "no admin")"
    }
  }
  
  func showAlert(message: String){
    let alert = UIAlertController(title: "Alert", message: message, preferredStyle: .alert)
    alert.addAction(UIAlertAction(title: "Cancel", style: .destructive))
    alert.addAction(UIAlertAction(title: "Go to settings", style: .default, handler: { action in
      UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!)
    }))
    present(alert,animated: true)
  }
}

//MARK: -IBActions
private extension LocationViewController{
  @IBAction func confirmAddress(_ sender: UIButton){
    self.navigationController?.pushViewController(AddressConfirmationViewController(), animated: true)
  }
  
  @IBAction func closeMap(_ sender: UIButton){
    self.navigationController?.popViewController(animated: true)
  }
  
  @IBAction func locateUser(_ sender: UIButton){
    pinLocation.isHidden = true
    userLocation.isHidden = false
    mapView.delegate = .none
    zoomToUserLocation(location: locationViewModel.userLLocation ?? CLLocation())
  }
  
  @IBAction func searchLocation(_ sender: UIButton){
    pinLocation.isHidden = true
    if searchTextField.text != "" {
      searchForDestination(destination: searchTextField.text ?? "")
      userLocation.isHidden = false
      mapView.delegate = .none
    }else{
      let alert = UIAlertController(title: "Alert", message: "Please Enter Your Destination", preferredStyle: .alert)
      alert.addAction(UIAlertAction(title: "Ok", style: .destructive))
      self.present(alert, animated: true)
    }
  }
  
  @IBAction func usePin(_ sender: UIButton){
    userLocation.isHidden = false
    pinLocation.isHidden = false
    mapView.delegate = self
    mapView.removeAnnotation(locationViewModel.searchAnnotation ?? MKPointAnnotation())
    mapView.removeAnnotation(locationViewModel.userAnnotation ?? MKPointAnnotation())
  }
}
//MARK: -CLLocationManagerDelegate
extension LocationViewController: CLLocationManagerDelegate{
  func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
    guard let location = locations.last else {return}
    locationViewModel.userLLocation = location
  }
  
  func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
    switch status{
    case .authorizedWhenInUse:
      locationViewModel.locationManager.startUpdatingLocation()
    case .authorizedAlways:
      locationViewModel.locationManager.startUpdatingLocation()
    case .denied:
      showAlert(message: "Please allow access to location")
    default:
      break
    }
  }
  func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
    print("Error: \(error.localizedDescription)")
  }
}
//MARK: -MKMapViewDelegate
extension LocationViewController: MKMapViewDelegate{
  func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
    getLocationInfo(location: CLLocation(latitude: mapView.centerCoordinate.latitude, longitude: mapView.centerCoordinate.longitude))
  }
}
