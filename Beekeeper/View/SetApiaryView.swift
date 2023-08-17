//
//  SetApiaryView.swift
//  Beekeeper
//
//  Created by Mariusz Zając on 17/08/2023.
//

import SwiftUI
import CoreLocationUI

struct SetApiaryView: View {
   
    @StateObject var locationManager = LocationManager()
    
    var body: some View {
        VStack {
            VStack {
                Text("Tutaj ustawimy podstawowe parametry dla pasieki takie jak w modelu i pobieramy lokalizację ")
            }
            .multilineTextAlignment(.center)
            
            LocationButton(.shareCurrentLocation) {
                locationManager.requestLocation()
            }
            .cornerRadius(30)
            .symbolVariant(.fill)
            .foregroundColor(.white)
        }
    }
}

struct SetApiaryView_Previews: PreviewProvider {
    static var previews: some View {
        SetApiaryView()
    }
}
