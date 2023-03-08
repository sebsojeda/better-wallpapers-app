//
//  TagsView.swift
//  BetterWallpapers
//
//  Created by Sebastian Ojeda on 1/26/23.
//

import SwiftUI

extension Image {
    func withTagStyles() -> some View {
        self.resizable()
            .aspectRatio(contentMode: .fill)
            .frame(width: 135, height: 90)
            .clipped()
    }
}

struct TagsView: View {
    @EnvironmentObject var settings: Settings
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            LazyVGrid(columns: [GridItem(.fixed(135)), GridItem(.fixed(135)), GridItem(.fixed(135))]) {
                ForEach(0..<settings.tags.count, id: \.self) { i in
                    Button(action: { toggleTag(i) }) {
                        Image(settings.tags[i].image)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 135, height: 90)
                            .clipped()
                            .overlay(alignment: .bottomLeading) {
                                Text(settings.tags[i].title)
                                    .foregroundColor(.white)
                                    .shadow(color: .black, radius: 1, x: 0, y: 1)
                                    .padding()
                            }
                            .overlay(alignment: .topTrailing) {
                                if settings.tags[i].checked {
                                    Image(systemName: "checkmark.square.fill")
                                        .renderingMode(.original)
                                        .font(.system(size: 17))
                                        .padding()
                                } else {
                                    Image(systemName: "square.fill")
                                        .renderingMode(.original)
                                        .foregroundColor(Color(.disabledControlTextColor))
                                        .font(.system(size: 17))
                                        .padding()
                                }
                            }
                            
                    }
                    .frame(width: 135, height: 90)
                    .buttonStyle(.plain)
                    .cornerRadius(5)
                }
            }
        }
        .padding()
    }
    
    func toggleTag(_ index: Int) {
        if !settings.tags[index].checked {
            settings.tags[index].checked.toggle()
            return
        }
        
        var count = 0
        for tag in settings.tags {
            if tag.checked {
                count += 1
            }
        }
        if count > 1 {
            settings.tags[index].checked.toggle()
        }
    }
}

struct TagsView_Previews: PreviewProvider {
    static var previews: some View {
        TagsView()
            .environmentObject(Settings())
    }
}
