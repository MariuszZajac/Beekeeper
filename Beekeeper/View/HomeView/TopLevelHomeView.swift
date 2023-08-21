//
//  TopLevelHomeView.swift
//  Beekeeper
//
//  Created by Mariusz Zając on 17/08/2023.
//

import SwiftUI

struct TopLevelHomeView: View {
    var body: some View {
        HStack {
            NavigationLink(destination: UserInfoView()) {
                Image(systemName: "person.circle")
                    .foregroundColor(.black)
            }
            
            Spacer()
            
            NavigationLink(destination: SettingsView()) {
                Image(systemName: "gearshape")
                    .foregroundColor(.black)
            }
        }
        .padding()
        .frame(maxHeight: 100)
    }
}
