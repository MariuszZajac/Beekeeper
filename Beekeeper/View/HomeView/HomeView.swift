//
//  HomeView.swift
//  Beekeeper
//
//  Created by Mariusz Zając on 17/08/2023.
//

import SwiftUI

struct HomeView: View {
    
    @EnvironmentObject var viewModel: SetApiaryViewModel

    var body: some View {
        
            ScrollView{
                VStack {
                    VStack {
                        TopLevelHomeView()
                    }
                    .frame(maxHeight: 20)
                    ScrollView(.horizontal) {
                        HStack{
                            ForEach(viewModel.apiaries) { apiary in
                                WeatherView(viewModel: WeatherViewModel(apiary: apiary))
                            }
                        }
                        .onAppear {
                            print(viewModel.apiaries.count)
                        }
                    }
                    // SetApiaryView()
                    ToDoListView() //zadania do wykonania w pasiece zaplanowane
                    
                }
            }
        }
    }


struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView().environmentObject(SetApiaryViewModel())    }
}