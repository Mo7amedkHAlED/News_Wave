//
//  HeadlineView.swift
//  News App
//
//  Created by Mohamed Khaled Gomaa on 18/12/2023.
//

import SwiftUI

struct HeadlineView: View {
    // MARK:  Varables
    @StateObject var vm: HeadlineViewModel
    @State var isHeadline: Bool = true
    
    // MARK:  Body
    var body: some View {
        
        if vm.isLoading {
            ProgressView()
        } else {
            ScrollView {
                LazyVGrid(columns: [GridItem(), GridItem()]) {
                    ForEach(vm.headlineData ?? [], id: \.title) { article in
                        NavigationLink(destination: DetailsView(article: article)) {
                            NewsRowView(newsInfo: article, isHeadline: $isHeadline)
                        }
                        .frame(height: 260)
                        .listRowInsets(.init(top: 0, leading: 0, bottom: 0, trailing: 0))
                    }
                    ProgressView()
                        .onAppear {
                            vm.loadNextPage()
                        }
                } .padding()
            }
            .navigationTitle("Headline")
        }
    }
}

// MARK:  PreviewProvider
struct HeadlineView_Previews: PreviewProvider {
    static var previews: some View {
        HeadlineView(vm: HeadlineViewModel())
    }
}
