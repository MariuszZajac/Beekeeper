//
//  UserInfoView.swift
//  Beekeeper
//
//  Created by Mariusz Zając on 17/08/2023.
//

import SwiftUI

struct UserInfoView: View {
    var body: some View {
        NavigationLink(destination: Text("UserInfo")) {
            VStack {
                Text("Tu będzie widok Info o user")
            }
        }
        
    }
}

struct UserInfoView_Previews: PreviewProvider {
    static var previews: some View {
        UserInfoView()
    }
}
