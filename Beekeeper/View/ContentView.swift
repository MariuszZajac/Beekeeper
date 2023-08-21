//
//  ContentView.swift
//  Beekeeper
//
//  Created by Mariusz Zając on 17/08/2023.
//

import SwiftUI



struct ContentView: View {
    @StateObject private var setApiaryViewModel = SetApiaryViewModel()
    
    var body: some View {
        
        NavigationView {
            VStack {
            //SetApiaryView()
            
            TabView {

                    HomeView()
                        .environmentObject(setApiaryViewModel)
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
                .accentColor(.black)
                .background(Color.white)
            
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
//TODO: dark mode
//
