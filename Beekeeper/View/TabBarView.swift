//
//  TabBarView.swift
//  Beekeeper
//
//  Created by Mariusz Zając on 16/08/2023.
//

import SwiftUI

struct TabBarView: View {
    var body: some View {
        TabView {
            NavigationView {
                MainView()
            }
            .tabItem {
                Label("Home", systemImage: "house.circle.fill")
            }
            BalanceView()
                .tabItem {
                    Label("Balance", systemImage: "dollarsign.circle.fill")
                }
            
            HervestView()
                .tabItem {
                    Label("Honey Hervest", systemImage: "box.truck.fill")
                }
            
            InspectionView()
                .tabItem {
                    Label("Inspection", systemImage: "figure.walk")
                }
        }
    }
}

struct TabBarView_Previews: PreviewProvider {
    static var previews: some View {
        TabBarView()
    }
}
