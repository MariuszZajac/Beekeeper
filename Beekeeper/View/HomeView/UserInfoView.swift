//
//  UserInfoView.swift
//  Beekeeper
//
//  Created by Mariusz Zając on 17/08/2023.
//

import SwiftUI

struct UserInfoView: View {
    @StateObject var viewModel = SetApiaryViewModel()

    var body: some View {
        VStack {
            ApiariesListView(viewModel: viewModel)
            
        }
    }
}

struct UserInfoView_Previews: PreviewProvider {
    static var previews: some View {
        UserInfoView()
    }
}
