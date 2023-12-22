//
//  HeadlineView.swift
//  News App
//
//  Created by Mohamed Khaled Gomaa on 18/12/2023.
//

import SwiftUI

struct HeadlineView: View {
    @EnvironmentObject private var vm: HomeViewModel
    @State var isHeadline: Bool = true

    var body: some View {
        List {
            LazyVGrid(columns: [GridItem(), GridItem()]) {
                ForEach(vm.newsInfo ?? [], id: \.title) { article in
                    NewsRowView(newsInfo: article, isHeadline: $isHeadline)
                        .listRowInsets(.init(top: 10, leading: 0, bottom: 10, trailing: 10))
                }.frame(height: 250)
            }
        }
        .onAppear {
            Task {
                do {
                    try await vm.viewDidLoad()
                } catch {
                    print("Error: \(error)")
                }
            }
        }
        .navigationTitle("Headline")
    }
}

struct HeadlineView_Previews: PreviewProvider {
    static var previews: some View {
        HeadlineView()
            .environmentObject(HomeViewModel())
    }
}
// MARK: Anther way for show data
//List {
//    ForEach(vm.newsInfo?.chunks(of: 2) ?? [], id: \.first?.title) { pair in
//        HStack(spacing: 10) {
//            ForEach(pair, id: \.title) { article in
//                NewsRowView(newsInfo: article, isHeadline: $isHeadline)
//                    .listRowInsets(.init(top: 10, leading: 0, bottom: 10, trailing: 10))
//                    .frame( height: 250)
//                    .frame(maxWidth: .infinity)
//            }
//        }
//    }
//}
