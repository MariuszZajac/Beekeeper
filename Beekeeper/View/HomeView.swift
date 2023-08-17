//
//  HomeView.swift
//  Beekeeper
//
//  Created by Mariusz Zając on 17/08/2023.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        NavigationLink(destination: Text("Home View")) {
            VStack{
                
                HStack{
                    WeatherView()
                    // dla każdej pasieki osobna pogoda
                }
                
                ToDoListView() //zadania do wykonania w pasiece zaplanowane
                
                
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
