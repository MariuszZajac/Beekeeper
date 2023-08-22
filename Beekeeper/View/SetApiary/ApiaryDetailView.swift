//
//  ApiaryDetailView.swift
//  Beekeeper
//
//  Created by Mariusz Zając on 22/08/2023.
//
import SwiftUI

struct ApiaryDetailView: View {
    var apiary: Apiary
    
    var body: some View {
        VStack(spacing: 16) {
            Text("Informacje o pasiekach")
                .font(.headline)
           
            Text("Nazwa pasieki: \(apiary.apiaryName)")
            Text("Właściciel: \(apiary.apiaryOwner)")
            if let location = apiary.apiaryLocation {
                Text("Współrzędne GPS: \(location.latitude), \(location.longitude)")
            } else {
                Text("Współrzędne GPS: nieznane") //musimy utworzyć nową pasiekę. 
            }
        }
        .padding()
    }
}

struct ApiaryDetailView_Previews: PreviewProvider {
    static var previews: some View {
        let sampleApiary = Apiary(id: UUID(),
                                  apiaryName: "Przykładowa Pasieka",
                                  apiaryLocation: ApiaryLocation(id: UUID(), longitude: 55.23, latitude: 23.23),
                                  apiaryOwner: "Jan Kowalski")
        ApiaryDetailView(apiary: sampleApiary)
    }
}
