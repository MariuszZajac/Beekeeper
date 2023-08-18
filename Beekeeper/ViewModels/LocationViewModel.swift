import Foundation
import CoreLocation

class LocationViewModel: ObservableObject {
    @Published var selectedLocation: ApiaryLocation?
    
    func updateLocation(latitude: Double, longitude: Double) {
        selectedLocation = ApiaryLocation(id: UUID(), longitude: longitude, latitude: latitude)
    }
    
    func getCoordinatesFromAddress(address: String) {
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(address) { [weak self] (placemarks, error) in
            guard let self = self,
                  let placemark = placemarks?.first,
                  let location = placemark.location else {
                return
            }
            
            self.updateLocation(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        }
    }
}
