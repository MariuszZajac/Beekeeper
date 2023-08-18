import SwiftUI

struct SetApiaryView: View {
    @State private var address = ""
    @ObservedObject var viewModel = LocationViewModel()
    
    var body: some View {
        VStack {
            if viewModel.selectedLocation != nil {
                MapView(selectedLocation: $viewModel.selectedLocation)
                    .frame(height: 300)
            }
            
            TextField("Wprowadź adres", text: $address)
                .padding()
                .border(Color.gray, width: 1)
            
            Button("Pobierz dane GPS") {
                viewModel.getCoordinatesFromAddress(address: address)
            }
            .accentColor(.black)
            .background(Color.white)
            
            
            if let latitude = viewModel.selectedLocation?.latitude,
               let longitude = viewModel.selectedLocation?.longitude {
                // TODO: text do poprawki
                Text("Szerokość geograficzna: \(latitude)")
                Text("Długość geograficzna: \(longitude)")
            }
        }
        .padding()
    }
}
struct SetApiaryView_Previews: PreviewProvider {
    static var previews: some View {
        SetApiaryView()
    }
}
