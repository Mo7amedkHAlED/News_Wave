//
//  News_AppApp.swift
//  News App
//
//  Created by Mohamed Khaled Gomaa on 14/12/2023.
//

import SwiftUI

@main
struct News_AppApp: App {
    @StateObject private var vm = HomeViewModel()
    var body: some Scene {
        WindowGroup {
            NavigationView {
                MainView()
            } .environmentObject(vm)
        }
    }
}
