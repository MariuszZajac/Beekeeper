import SwiftUI
import MapKit

struct MapView: View {
    @ObservedObject var locationViewModel: LocationViewModel

    // Funkcja pomocnicza do tworzenia regionu
    private var mapRegion: Binding<MKCoordinateRegion> {
        Binding(
            get: {
                if let location = locationViewModel.selectedLocation {
                    return MKCoordinateRegion(
                        center: CLLocationCoordinate2D(latitude: location.latitude, longitude: location.longitude),
                        span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
                    )
                }
                // Domyślny region (możesz tu wpisać dowolne wartości)
                return MKCoordinateRegion(
                    center: CLLocationCoordinate2D(latitude: 0, longitude: 0),
                    span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
                )
            },
            set: { newRegion in
                // Tutaj możesz zaktualizować ViewModel na podstawie nowego regionu, jeśli to konieczne.
            }
        )
    }

    var body: some View {
        if let location = locationViewModel.selectedLocation {
            Map(
                coordinateRegion: mapRegion,
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
