//
//  NewsRowView.swift
//  News App
//
//  Created by Mohamed Khaled Gomaa on 16/12/2023.
//

import SwiftUI

struct NewsRowView: View {
    @Binding var isHeadline: Bool
    let newsInfo : Article
    init(newsInfo: Article, isHeadline: Binding<Bool>) {
        self._isHeadline = isHeadline
        self.newsInfo = newsInfo
    }
    
    var body: some View {
        VStack(alignment: .leading ,spacing: 6){
            if let imageURLString = newsInfo.urlToImage{
                AsyncImage(url: URL(string: imageURLString)) { phase in
                    switch phase {
                    case .empty:
                        Image("ProgressLoading")
                            .resizable() // Make the image resizable
                            .frame(height: isHeadline ? 100 : 190)
                            .cornerRadius(10)
                    case .success(let image):
                        image
                            .resizable() // Make the image resizable
                            .scaledToFit()
                            .cornerRadius(10)
                    case .failure:
                        Image("faildImage")
                            .resizable() // Make the image resizable
                            .frame(height: isHeadline ? 100 : 160)
                            .cornerRadius(10)
                    @unknown default:
                        Text("Unknown state")
                    }
                }
            } else {
                Image("faildImage")
                    .resizable() // Make the image resizable
                    .frame(height: isHeadline ? 100 : 190)
                    .cornerRadius(10)
            }
            
            Text(newsInfo.title ?? "")
                .fontWeight(.bold)
                .font(.system(size: 15))
                .multilineTextAlignment(.leading)
            if isHeadline {
                Spacer()
            }
            Text(!isHeadline ? newsInfo.description ?? "" : newsInfo.author ?? "")
                .font(.callout)
                .font(.system(size: 14))
                .foregroundColor(.gray)
                .lineLimit(3)            
        }
        .padding(.all)
        .background(
            RoundedRectangle(cornerRadius: 10) // Apply the shadow to a rounded rectangle
                .foregroundColor(.white) // Match the background color
                .shadow(radius: 10)
        )
    }
}

struct NewsRowView_Previews: PreviewProvider {
    static var previews: some View {
        NewsRowView(newsInfo: (dev.news.articles?.first!)!, isHeadline: .constant(false))
            .frame(height: 300)
    }
}
