//
//  PropertiesItemView.swift
//  Pokemon-SwiftUI-App
//
//  Created by Berker Saptas on 16.10.2023.
//

import SwiftUI

struct PropertiesItemView<T: Identifiable, Content: View>: View {
    let items: [T]
    let title: String
    let content: (T) -> Content
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(title).font(.headline)
            HStack {
                ForEach(items.indices, id: \.self) { index in
                    content(items[index]).frame(height: 20)
                    if index < items.count - 1 {
                        Divider().frame(height: 20).background(Color.black)
                    }
                }
            }
        }
    }
}
