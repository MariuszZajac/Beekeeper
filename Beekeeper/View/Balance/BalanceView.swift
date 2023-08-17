//
//  BalanceView.swift
//  Beekeeper
//
//  Created by Mariusz Zając on 17/08/2023.
//

import SwiftUI

struct BalanceView: View {
    var body: some View {
        NavigationLink(destination: Text("Balance Details")) {
            VStack {
            Text("Tu będzie widok finansów pasieki")
        }
        }
    }
}

struct BalanceView_Previews: PreviewProvider {
    static var previews: some View {
        BalanceView()
    }
}
