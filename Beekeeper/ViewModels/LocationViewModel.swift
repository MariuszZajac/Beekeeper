import Foundation
import CoreLocation

class LocationViewModel: ObservableObject {
    @Published var selectedLocation: ApiaryLocation?
    @Published var address = ""
    
    func updateLocation(latitude: Double, longitude: Double) {
        selectedLocation = ApiaryLocation(id: UUID(), longitude: longitude, latitude: latitude)
    }
    
    func getCoordinatesFromAddress(address: String, completion: @escaping (ApiaryLocation?) -> Void) {
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(address) { [weak self] (placemarks, error) in
            guard let placemark = placemarks?.first, let location = placemark.location else {
                completion(nil)
                return
            }
            
            let locationData = ApiaryLocation(id: UUID(), longitude: location.coordinate.longitude, latitude: location.coordinate.latitude)
            self?.selectedLocation = locationData
            completion(locationData)
        }
    }

}
