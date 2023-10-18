//
//  MainPageView.swift
//  Pokemon-SwiftUI-App
//
//  Created by Berker Saptas on 9.10.2023.
//

import SwiftUI

struct MainPageView: View {
    
    @State var selectedSideMenuTab = 0
    
    var body: some View {
        ZStack {
            TabView(selection: $selectedSideMenuTab) {
                NavigationStack {
                    PokemonListView()
                }
                .tag(0)
                .tabItem {
                    Image(systemName: "house")
                }
                NavigationStack {
                    FavoritePokemonView()
                }
                .tag(1)
                .tabItem {
                    Image(systemName: "heart")
                }
            }
            .accentColor(.primary)
        }
    }
}

struct MainPageView_Previews: PreviewProvider {
    static var previews: some View {
        MainPageView()
    }
}
