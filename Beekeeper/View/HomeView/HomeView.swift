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
            ScrollView{
                VStack {
                    VStack {
                        TopLevelHomeView()
                    }
                    .frame(maxHeight: 20)
                    ScrollView(.horizontal) {
                        HStack{
                            WeatherView(viewModel: WeatherViewModel(apiaryLocation: ApiaryLocation(id: UUID(), longitude: 55.23, latitude: 23.23)))
                            // dla każdej pasieki osobna pogoda
                        }
                    }
                   // SetApiaryView()
                    ToDoListView() //zadania do wykonania w pasiece zaplanowane
                    
                }
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
