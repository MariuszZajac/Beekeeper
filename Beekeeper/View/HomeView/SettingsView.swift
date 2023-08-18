//
//  Settings.swift
//  Beekeeper
//
//  Created by Mariusz Zając on 17/08/2023.
//

import SwiftUI

struct SettingsView: View {
    var body: some View {
        NavigationLink(destination: Text("Settings")) {
            VStack {
                Text("Tu będzie widok settings")
            }
        }
    }
}

struct Settings_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
