import SwiftUI
import MapKit

struct MapView: View {
    @ObservedObject var locationViewModel: LocationViewModel

    var body: some View {
        if let location = locationViewModel.selectedLocation {
            Map(
                coordinateRegion: Binding(
                    get: {
                        MKCoordinateRegion(
                            center: CLLocationCoordinate2D(latitude: location.latitude, longitude: location.longitude),
                            span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
                        )
                    },
                    set: { newRegion in
                        // Tutaj możesz zaktualizować ViewModel na podstawie nowego regionu, jeśli to konieczne.
                    }
                ),
                showsUserLocation: true,
                userTrackingMode: .constant(.follow),
                annotationItems: [location]
            ) { location in
                MapMarker(coordinate: CLLocationCoordinate2D(latitude: location.latitude, longitude: location.longitude), tint: .blue)
            }
            .gesture(
                MagnificationGesture()
                    .onChanged { scale in
                        // Tutaj możesz zaktualizować ViewModel na podstawie zmiany skali.
                    }
            )
        } else {
            Text("Wybierz lokalizację")
        }
    }
}
