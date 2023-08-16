//
//  ContentView.swift
//  Beekeeper
//
//  Created by Mariusz Zając on 15/08/2023.
//

import SwiftUI

struct MainView: View {
    var body: some View {
        VStack{
            HStack{
                WeatherView()// dla każdej pasieki osobna pogoda 
            }
            
            ToDoListView()
            
            TabBarView()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
