import SwiftUI

struct SetApiaryView: View {
    @StateObject var locationViewModel = LocationViewModel()
    @StateObject var viewModel: SetApiaryViewModel
    
    init() {
        _viewModel = StateObject(wrappedValue: SetApiaryViewModel())
    }
    
    
    var body: some View {
        VStack {
            VStack {
                TextField("Nazwa pasieki", text: $viewModel.apiaryName)
                    .padding()
                    .border(Color.gray, width: 1)
                
                TextField("Właściciel pasieki", text: $viewModel.apiaryOwner)
                    .padding()
                    .border(Color.gray, width: 1)
                
                VStack {
                    TextField("Wprowadź adres", text: $viewModel.address)
                        .padding()
                        .border(Color.gray, width: 1)
                    
                    
                    Button("Pobierz dane GPS") {
                        locationViewModel.getCoordinatesFromAddress(address: viewModel.address)
                    }
                }
            }
            if locationViewModel.selectedLocation != nil {
                VStack  {
                    MapView(locationViewModel: locationViewModel)
                        .frame(height: 300)
                }
            }
            if let apiaryLocation = locationViewModel.selectedLocation {
                Button("Stwórz pasiekę") {
                    if let newApiary = viewModel.createApiary() {
                        // Tutaj możesz coś zrobić z nowo utworzoną pasieką
                        print("Utworzono pasiekę: \(newApiary)")
                    }
                }
                .accentColor(.black)
                .background(Color.white)
                
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
