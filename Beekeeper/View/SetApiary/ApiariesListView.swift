//
//  ApiariesListView.swift
//  Beekeeper
//
//  Created by Mariusz Zając on 22/08/2023.
//

import SwiftUI

struct ApiariesListView: View {
    @ObservedObject var viewModel: SetApiaryViewModel

    var body: some View {
        NavigationView {
            // Sprawdzanie, czy są jakieś pasieki
            if viewModel.apiary.isEmpty {
                // Widok wyświetlany, gdy nie ma pasiek
                VStack {
                    Text("Nie masz jeszcze żadnych pasiek.")
                    NavigationLink(destination: SetApiaryView(viewModel: viewModel)) {
                        Text("Dodaj Pasiekę")
                    }
                }
            } else {
                // Lista pasiek, gdy są dostępne
                List(viewModel.apiary) { apiary in
                    NavigationLink(destination: ApiaryDetailView(apiary: apiary)) {
                        VStack(alignment: .leading) {
                            Text(apiary.apiaryName)
                            Text("Właściciel: \(apiary.apiaryOwner)")
                        }
                    }
                }
                .navigationTitle("Moje Pasieki")
            }
        }
    }
}



struct ApiariesListView_Previews: PreviewProvider {
    static var previews: some View {
        ApiariesListView(viewModel: SetApiaryViewModel())
    }
}
