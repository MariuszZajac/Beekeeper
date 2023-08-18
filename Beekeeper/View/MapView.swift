import SwiftUI
import MapKit

struct MapView: View {
    @Binding var selectedLocation: ApiaryLocation?
    
    var body: some View {
        if let location = selectedLocation {
            Map(
                coordinateRegion: .constant(
                    MKCoordinateRegion(
                        center: CLLocationCoordinate2D(latitude: location.latitude, longitude: location.longitude),
                        span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
                    )
                ),
                showsUserLocation: true,
                userTrackingMode: .constant(.follow),
                annotationItems: [location]
            ) { location in
                MapMarker(coordinate: CLLocationCoordinate2D(latitude: location.latitude, longitude: location.longitude), tint: .blue)
            }
        } else {
            Text("Wybierz lokalizację")
        }
    }
}
