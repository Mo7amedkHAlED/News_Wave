//
//  HomeView.swift
//  News App
//
//  Created by Mohamed Khaled Gomaa on 16/12/2023.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject private var vm: HomeViewModel
    @State var isHeadline: Bool = false
    var body: some View {
        ScrollView {
            VStack {
                if vm.isLoading {
                    ProgressView()
                } else {
                    SearchBarView(searchText: $vm.searchText)
                    Spacer()
                    allNewsList
                }
            }
            .navigationTitle("Home")
        }
    }
    
    private var allNewsList: some View {
        LazyVStack (alignment: .leading) {
            ForEach(vm.newsInfo ?? [],id: \.title) { article in
                withAnimation(.easeOut) {
                    NavigationLink(destination: DetailsView(article: article)) {
                        NewsRowView(newsInfo: article, isHeadline: $isHeadline)
                            .listRowInsets(.init(top: 10, leading: 0, bottom: 10, trailing: 10))
                            .onAppear {
                                if article.title == vm.newsInfo?.last?.title {
                                    vm.loadNextPage()
                                }
                            }
                    }
                }
            }
            .padding(.trailing)
            .padding(.leading)
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            HomeView()
                .environmentObject(HomeViewModel())
        }
    }
}
