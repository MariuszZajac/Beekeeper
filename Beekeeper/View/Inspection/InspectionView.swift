//
//  InspectionView.swift
//  Beekeeper
//
//  Created by Mariusz Zając on 17/08/2023.
//

import SwiftUI

struct InspectionView: View {
    var body: some View {
        NavigationLink(destination: Text("Inspection Details")) {
            VStack {
                Text("Tu będzie widok inspekcji w ulu")
            }
        }
    }
}

struct InspectionView_Previews: PreviewProvider {
    static var previews: some View {
        InspectionView()
    }
}
