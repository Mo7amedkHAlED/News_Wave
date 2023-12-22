//
//  DetailsView.swift
//  News App
//
//  Created by Mohamed Khaled Gomaa on 18/12/2023.
//

import SwiftUI

struct DetailsView: View {
    var article: Article
    
    init(article: Article) {
        self.article = article
    }
    
    var body: some View {
        ScrollView {
            VStack (alignment: .leading, spacing: 10) {
                AsyncImage(url: URL(string: article.urlToImage ?? "")) { phase in
                    switch phase {
                    case .empty:
                        Image("ProgressLoading")
                            .resizable() // Make the image resizable
                            .frame(height: 200)
                            .cornerRadius(10)
                    case .success(let image):
                        image
                            .resizable() // Make the image resizable
                            .scaledToFit()
                            .cornerRadius(10)
                    case .failure:
                        Image("faildImage")
                            .resizable() // Make the image resizable
                            .frame(height:  300)
                            .cornerRadius(10)
                    @unknown default:
                        Text("Unknown state")
                    }
                }
                
                HStack {
                    Text(article.author ?? "")
                    Spacer()
                    Text(article.publishedAt?.timeConvert() ?? "")
                }
                Text(article.title ?? "")
                    .fontWeight(.bold)
                Text(article.description ?? "")
                    .fontWeight(.medium)
                    .foregroundColor(.gray)
            }
        }.padding()
       .navigationTitle("Details")
    }
}

struct DetailsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            DetailsView(article: ( (dev.news.articles?.first!)!))
        }
    }
}
