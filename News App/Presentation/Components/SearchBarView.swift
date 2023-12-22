//
//  SearchBarView.swift
//  Crypto SwiftUI
//
//  Created by Mohamed Khaled Gomaa on 23/11/2023.
//

import SwiftUI

struct SearchBarView: View {
    
    @Binding var searchText: String
    
    var body: some View {
        
        HStack{
            Image(systemName: "magnifyingglass")
                .foregroundColor(
                    // change icone color when start writting
                    searchText.isEmpty ?
                    Color.theme.secondaryText : Color.theme.accent
                )
            TextField("Search by name or symbol", text: $searchText)
                .foregroundColor(Color.theme.accent)
                .disableAutocorrection(true)
                .keyboardType(.webSearch)
                .overlay(alignment: .trailing) {
                    Image(systemName: "xmark.circle.fill")
                        .padding()
                        .offset(x: 10) // increase click area
                        .foregroundColor(Color.theme.accent)
                        .opacity(searchText.isEmpty ? 0.0 : 1.0)
                        .onTapGesture {
                            // to dismiss keyboard
                            UIApplication.shared.endEditing()
                            searchText = ""
                        }
                }
        }
        .font(.headline)
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 25)
                .fill(Color.theme.background)
                .shadow(color: Color.theme.accent.opacity(0.15), radius: 10, x: 0, y: 0)
        )
        .padding()
    }
}

struct SearchBarView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            SearchBarView(searchText: .constant(""))
                .previewLayout(.sizeThatFits)
        }
    }
}

