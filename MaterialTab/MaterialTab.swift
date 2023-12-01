//
//  MaterialTab.swift
//  Wagyufari
//
//  Created by Muhammad Ghifari on 23/11/2023.
//

import Foundation
import SwiftUI

struct MaterialTab: View {
    
    @Binding var currentIndex: Int
    let pages: [TabViewPage]
    var mode: MaterialTabMode = .Fixed
    @State private var tabsRect: [String: CGRect] = [:]
    
    var body: some View{
        VStack(spacing: 0){
            ZStack(alignment: .topLeading){
                
                ScrollViewReader(content: { proxy in
                    VStack{
                        if mode == .Fixed {
                            content()
                        } else {
                            ScrollView(.horizontal, showsIndicators: false){
                                content()
                            }
                        }
                    }
                    .onChange(of: currentIndex) { currentPage in
                        withAnimation{
                            proxy.scrollTo(currentPage)
                        }
                    }
                })
                if let guideRect = tabsRect[pages[currentIndex].title] {
                    Rectangle()
                        .position(x: guideRect.midX, y: guideRect.height - 1)
                        .frame(width: guideRect.width, height: 2)
                        .foregroundStyle(Color.purple)
                        .animation(.linear(duration: 0.1))
                }
            }
            Divider()
        }
    }
    
    func content() -> some View {
        HStack(spacing: 0){
            ForEach(Array(pages.enumerated()), id: \.element.title) { index, page in
                let isSelected = index == currentIndex
                Text("\(page.title)")
                    .font(.system(size: 16))
                    .frame(maxWidth: mode == .Scrollable ? nil : .infinity)
                    .foregroundStyle(isSelected ? Color.purple : Color.black)
                    .padding(.vertical, 12)
                    .padding(.horizontal, 16)
                    .background(GeometryReader { geo -> Color in
                        DispatchQueue.main.async {
                            tabsRect[page.title] = geo.frame(in: .global)
                        }
                        return Color.white
                    })
                    .id(index)
                    .onTapGesture {
                        withAnimation {
                            currentIndex = index
                        }
                    }
            }
        }
    }
}


enum MaterialTabMode {
    case Fixed
    case Scrollable
}

struct TabViewPage {
    let title: String
    let content: () -> AnyView
    
    init<Content: View>(_ title: String, @ViewBuilder content: @escaping () -> Content) {
        self.title = title
        self.content = { AnyView(content()) }
    }
}
