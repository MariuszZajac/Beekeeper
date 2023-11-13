//
//  WeatherRow.swift
//  Beekeeper
//
//  Created by Mariusz Zając on 17/08/2023.
//

import SwiftUI

struct WeatherRow: View {
    var logo: String
    var name: String
    var value: String
    
    var body: some View {
        HStack(spacing: 20) {
            Image(systemName: logo)
                .font(.title2)
                .frame(width: 5 , height: 5)
                .padding()
                .background(Color.gray)
                .cornerRadius(50)
            
            VStack(alignment: .leading, spacing: 8) {
                Text(name)
                    .font(.caption)
                Text(value)
                    .bold()
                    .font(.headline)
                    
            }
            
        }
       // .frame(width: 40, height: 50)
    }
}

struct WeatherRow_Previews: PreviewProvider {
    static var previews: some View {
        WeatherRow(logo: "thermometer", name: "temp", value: "8°")
    }
}
