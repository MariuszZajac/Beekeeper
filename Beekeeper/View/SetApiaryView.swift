import SwiftUI
import CoreLocation

struct SetApiaryView: View {
    @StateObject var locationViewModel = LocationViewModel()
    @StateObject var viewModel: SetApiaryViewModel
  //  @StateObject var adress = ""
    init() {
        _viewModel = StateObject(wrappedValue: SetApiaryViewModel())
    }
    
    var body: some View {
        VStack(spacing: 16) {
            
            // Map View
            if locationViewModel.selectedLocation != nil {
                MapView(locationViewModel: locationViewModel)
                    .frame(height: 300)
            }
            
            // Apiary Name TextField
            TextField("Nazwa pasieki", text: $viewModel.apiaryName)
                .padding()
                .border(Color.gray, width: 1)
            
            // Apiary Owner TextField
            TextField("Właściciel pasieki", text: $viewModel.apiaryOwner)
                .padding()
                .border(Color.gray, width: 1)
            
            // Address and GPS Button
            VStack {
                TextField("Wprowadź adres", text: $viewModel.address)
                    .padding()
                    .border(Color.gray, width: 1)
                
                Button(action: {
                    locationViewModel.getCoordinatesFromAddress(address: viewModel.address) { location in
                        viewModel.selectedLocation = location
                    }
                }, label: {
                    Text("Pobierz dane GPS")
                })

                
                
                // Create Apiary Button
                if locationViewModel.selectedLocation != nil {
                    Button("Stwórz pasiekę") {
                        do {
                            let newApiary = try viewModel.createApiary()
                            viewModel.apiary.append(newApiary) // Dodawanie nowej pasieki do listy
                            print("Utworzono pasiekę: \(newApiary)")
                        } catch {
                            print("Błąd podczas tworzenia pasieki: \(error.localizedDescription)")
                        }
                    }

                    .accentColor(.black)
                    .background(Color.white)
                }
            }
            .padding()
        }
    }
}
struct SetApiaryView_Previews: PreviewProvider {
    static var previews: some View {
        SetApiaryView()
    }
}
