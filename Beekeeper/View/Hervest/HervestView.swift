//
//  HervestView.swift
//  Beekeeper
//
//  Created by Mariusz Zając on 17/08/2023.
//

import SwiftUI

struct HervestView: View {
    var body: some View {
        NavigationLink(destination: Text("Honey Harvest Details")) {
            VStack {
                Text("Tu będzie widok zbiorów miodu")
            }
        }
    }
}

struct HervestView_Previews: PreviewProvider {
    static var previews: some View {
        HervestView()
    }
}
