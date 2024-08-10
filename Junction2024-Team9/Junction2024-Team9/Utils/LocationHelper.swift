//
//  LocationHelper.swift
//  Junction2024-Team9
//
//  Created by Damin on 8/11/24.
//

import Foundation
import CoreLocation

class LocationHelper: NSObject, ObservableObject {
    static let shared = LocationHelper()
    
    @Published var currentLocation: CLLocation?
    @Published var currentAddress: String?
    
    private let locationManager = CLLocationManager()
    private let geocoder = CLGeocoder()
    
    override init() {
        super.init()
        locationManager.delegate = self
        checkLocationAuthorization()
    }
    func getCurrentAddress() -> String {
        guard let currentAddress else { return "위치정보 없음"}
        return currentAddress
    }
    
    func checkLocationAuthorization() {
        switch locationManager.authorizationStatus {
        case .authorizedAlways, .authorizedWhenInUse:
            locationManager.startUpdatingLocation()
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .restricted, .denied:
            print("위치 권한이 제한되었거나 거부되었습니다.")
        @unknown default:
            break
        }
    }
    func updateAddress(from location: CLLocation) {
        geocoder.reverseGeocodeLocation(location, preferredLocale: Locale(identifier: "en_US")) { [weak self] (placemarks, error) in
            if let error = error {
                print("주소 변환 실패: \(error.localizedDescription)")
                return
            }
            
            guard let placemark = placemarks?.first else {
                print("주소 정보를 가져올 수 없습니다.")
                return
            }
            
            // 한국 지역의 주소 형식으로 변환
            let country = placemark.country ?? ""
            let administrativeArea = placemark.administrativeArea ?? ""
            let locality = placemark.locality ?? ""
            let subLocality = placemark.subLocality ?? ""
            let thoroughfare = placemark.thoroughfare ?? ""
            let subThoroughfare = placemark.subThoroughfare ?? ""
            let postalCode = placemark.postalCode ?? ""
            
            // 주소 정보 결합
            self?.currentAddress = "\(country) \(administrativeArea) \(locality) \(subLocality) \(thoroughfare) \(subThoroughfare)"
        }
    }
}

extension LocationHelper: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        checkLocationAuthorization()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        self.currentLocation = location
        
        print("현재 위치가 업데이트되었습니다: \(location.coordinate.latitude), \(location.coordinate.longitude)")
        
        // 위치를 한국 주소로 변환
        updateAddress(from: location)
    }
}
