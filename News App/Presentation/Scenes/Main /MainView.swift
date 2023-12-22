//
//  MainView.swift
//  News App
//
//  Created by Mohamed Khaled Gomaa on 18/12/2023.
//

import SwiftUI

struct MainView: View {
    var body: some View {
        TabView {
            NavigationView {
                HomeView()
            }
            .tabItem {
                Label("Home", systemImage: "house")
            }
            NavigationView {
                HeadlineView(vm: HeadlineViewModel())
            }
            .tabItem {
                Label("Headline", systemImage: "info.circle")
            }
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
            MainView()
                .environmentObject(HomeViewModel())
                .navigationTitle("Home")
    }
}
