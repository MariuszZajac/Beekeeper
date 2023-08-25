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
            if viewModel.apiary.isEmpty {
                VStack {
                    Text("Nie masz jeszcze żadnych pasiek.")
                    NavigationLink(destination: SetApiaryView(viewModel: viewModel)) {
                        Text("Dodaj Pasiekę")
                    }
                }
            } else {
                List {
                    ForEach(viewModel.apiary) { apiary in
                        NavigationLink(destination: ApiaryDetailView(apiary: apiary)) {
                            VStack(alignment: .leading) {
                                Text(apiary.apiaryName)
                                Text("Właściciel: \(apiary.apiaryOwner)")
                            }
                        }
                    }
                    .onDelete(perform: viewModel.removeApiaries)
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
