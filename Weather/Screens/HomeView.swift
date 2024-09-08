//
//  HomeView.swift
//  Weather
//
//  Created by Harsh Pranay on 12/08/24.
//

import SwiftUI

struct HomeView: View {
    var body: some View {

        BlurryMountainView {
            BottomSheeetView(isScrollable: true) {
                Text("helllkzjc")
            }
            .offset(y: -30)
        }
    }
}

#Preview {
    HomeView()
}
