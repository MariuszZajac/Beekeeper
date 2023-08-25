import SwiftUI
import CoreLocation

struct SetApiaryView: View {
    @ObservedObject var viewModel: SetApiaryViewModel
    @StateObject var locationViewModel = LocationViewModel()
    @State private var isShowingAlert = false
    @State private var alertMessage = ""
    @Environment(\.presentationMode) var presentationMode
    
    
    init(viewModel: SetApiaryViewModel) {
        _viewModel = ObservedObject(wrappedValue: viewModel)
    }

    var body: some View {
        VStack(spacing: 16) {
            if locationViewModel.selectedLocation != nil {
                MapView(locationViewModel: locationViewModel)
                    .frame(height: 300)
                    .id(locationViewModel.selectedLocation)
            }
            ApiaryTextFields(apiaryName: $viewModel.apiaryName, apiaryOwner: $viewModel.apiaryOwner, address: $viewModel.address)
            
            Button("Pobierz dane GPS",action: {
                locationViewModel.getCoordinatesFromAddress(address: viewModel.address) { location in
                    viewModel.selectedLocation = location
                }
            })
            .buttonStyle(FilledRoundedCornerButtonStyle())

            // Create Apiary Button
            if locationViewModel.selectedLocation != nil {
                Button("Stwórz pasiekę") {
                    do {
                        let newApiary = try viewModel.createApiary()
                        viewModel.apiary.append(newApiary)
                        alertMessage = "Pasieka została utworzona pomyślnie!"
                        isShowingAlert = true
                        presentationMode.wrappedValue.dismiss()
                    } catch {
                        alertMessage = "Błąd podczas tworzenia pasieki: \(error.localizedDescription)"
                        isShowingAlert = true
                    }
                }
                .buttonStyle(FilledRoundedCornerButtonStyle())

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
        SetApiaryView(viewModel: SetApiaryViewModel())
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
