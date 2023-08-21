import SwiftUI
import CoreLocation

struct SetApiaryView: View {
//@StateObject var sharedApiaryViewModel = SetApiaryViewModel()
    @StateObject var locationViewModel = LocationViewModel()
    @StateObject var viewModel: SetApiaryViewModel
    @State private var isShowingAlert = false
    @State private var alertMessage = ""
    
    init() {
        _viewModel = StateObject(wrappedValue: SetApiaryViewModel())
    }
    
    var body: some View {
        VStack(spacing: 16) {
            if locationViewModel.selectedLocation != nil {
                MapView(locationViewModel: locationViewModel)
                    .frame(height: 300)
            }
            ApiaryTextFields(apiaryName: $viewModel.apiaryName, apiaryOwner: $viewModel.apiaryOwner, address: $viewModel.address)
            
            Button(action: {
                locationViewModel.getCoordinatesFromAddress(address: viewModel.address) { location in
                    viewModel.selectedLocation = location
                }
            }, label: {
                Text("Pobierz dane GPS")
                       .padding(.horizontal, 16)
                       .padding(.vertical, 8)
                       .background(Color.blue)
                       .foregroundColor(.white)
                       .clipShape(RoundedRectangle(cornerRadius: 10))
            })
            // Create Apiary Button
            if locationViewModel.selectedLocation != nil {
                Button("Stwórz pasiekę") {
                    do {
                        let newApiary = try viewModel.createApiary()
                        viewModel.apiary.append(newApiary)
                        alertMessage = "Pasieka została utworzona pomyślnie!"
                        isShowingAlert = true
                    } catch {
                        alertMessage = "Błąd podczas tworzenia pasieki: \(error.localizedDescription)"
                        isShowingAlert = true
                    }
                }
                .padding(.horizontal, 16)
                .padding(.vertical, 8)
                .background(Color.blue)
                .foregroundColor(.white)
                .clipShape(RoundedRectangle(cornerRadius: 10))
            }
        }
        .padding()
        .alert(isPresented: $isShowingAlert) {
            Alert(title: Text("Informacja"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
        }
    }
}
struct SetApiaryView_Previews: PreviewProvider {
    static var previews: some View {
        SetApiaryView()
    }
}

struct ApiaryTextFields: View {
    @Binding var apiaryName: String
    @Binding var apiaryOwner: String
    @Binding var address: String
    
    var body: some View {
        VStack(spacing: 16) {
            TextField("Nazwa pasieki", text: $apiaryName)
                .padding()
                .border(Color.gray, width: 1)
            
            TextField("Właściciel pasieki", text: $apiaryOwner)
                .padding()
                .border(Color.gray, width: 1)
            
            TextField("Wprowadź adres", text: $address)
                .padding()
                .border(Color.gray, width: 1)
        }
    }
}
