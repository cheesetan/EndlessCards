//
//  ContentView.swift
//  EndlessCards
//
//  Created by Tristan Chay on 17/7/24.
//

import SwiftUI

enum CardColors: Hashable, CaseIterable {
    case red, orange, yellow, green, blue
    
    var color: Color {
        switch self {
        case .red: return Color.red
        case .orange: return Color.orange
        case .yellow: return Color.yellow
        case .green: return Color.green
        case .blue: return Color.blue
        }
    }
}

struct ContentView: View {
    
    @State var colors: [CardColors] = [.red, .orange]
    @State var scrollPosition: Int?
    
    @State var forwardCount = 0
    @State var backwardCount = 1
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            ScrollViewReader { proxy in
                LazyHStack {
                    ForEach(colors.indices, id: \.description) { i in
                        RoundedRectangle(cornerRadius: 25)
                            .fill(colors[i].color)
                            .frame(width: 300, height: 100)
                            .id(i)
                            .overlay {
                                Text("\(i)")
                            }
                    }
                }
                .onChange(of: scrollPosition) { initial, new in
                    guard let initial = initial, let new = new else { return }
                    if new > initial {
                        colors.append(colors[forwardCount % (colors.count-1)])
                        forwardCount += 1
                    } else {
        //                colors.insert(colors[backwardCount % (colors.count-1)], at: 0)
        //                backwardCount += 1
                    }
                }
            }
            .scrollTargetLayout()
        }
        .scrollPosition(id: $scrollPosition)
        .scrollTargetBehavior(.viewAligned(limitBehavior: .always))
        .safeAreaPadding(.horizontal, 40)
    }
}

#Preview {
    ContentView()
}
