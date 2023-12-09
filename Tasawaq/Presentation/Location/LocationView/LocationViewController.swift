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
  
  var addressViewModel = LocationViewModel()
  override func viewDidLoad() {
    super.viewDidLoad()
    configureView()
    let initLocation = CLLocation(latitude: 30.06863, longitude: 31.24967)
    setStartingLocation(location: initLocation, distance: 400000)
    configureMap()
    checkLocationService()
  }
  
  override func viewWillAppear(_ animated: Bool) {
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
    addressViewModel.locationManager.delegate = self
    addressViewModel.locationManager.desiredAccuracy = kCLLocationAccuracyBest
    mapView.delegate = self
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
    switch addressViewModel.locationManager.authorizationStatus{
    case .authorizedWhenInUse:
      addressViewModel.locationManager.startUpdatingLocation()
    case .notDetermined:
      addressViewModel.locationManager.requestWhenInUseAuthorization()
    case .authorizedAlways:
      addressViewModel.locationManager.startUpdatingLocation()
    case .denied:
      showAlert(message: "Please allow access to location")
    case .restricted:
      showAlert(message: "Authorization restricted")
    default:
      break
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
}
//MARK: -CLLocationManagerDelegate
extension LocationViewController: CLLocationManagerDelegate{
  func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
    if let location = locations.last{
      print("location: \(location.coordinate)")
    }
  }
  
  func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
    switch status{
    case .authorizedWhenInUse:
      addressViewModel.locationManager.startUpdatingLocation()
    case .authorizedAlways:
      addressViewModel.locationManager.startUpdatingLocation()
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
  func getLocationInfo(location: CLLocation){
    let geoCoder = CLGeocoder()
    geoCoder.reverseGeocodeLocation(location) { places, error in
      guard let place = places?.first , error == nil else{return}
      self.userLocation.text = "\(place.name ?? "no name"),\(place.subLocality ?? "no subloc") ,\(place.administrativeArea ?? "no admin")"
    }
  }
}