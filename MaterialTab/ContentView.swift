//
//  ContentView.swift
//  MaterialTab
//
//  Created by Muhammad Ghifari on 1/12/2023.
//

import SwiftUI

struct ContentView: View {
    
    @State var pages: [TabViewPage] = []
    @State private var currentIndex = 0
    
    var body: some View {
        VStack {
            if !pages.isEmpty{
                fixedTabs()
                    .frame(maxHeight: .infinity)
                scrollableTabs()
                    .frame(maxHeight: .infinity)
            }
        }
        .onAppear{
            pages.append(TabViewPage("Page 1", content: {
                Page(text: "Page 1")
            }))
            pages.append(TabViewPage("Page 2", content: {
                Page(text: "Page 2")
            }))
            pages.append(TabViewPage("Page 3", content: {
                Page(text: "Page 3")
            }))
            pages.append(TabViewPage("Page 4", content: {
                Page(text: "Page 4")
            }))
            pages.append(TabViewPage("Page 5", content: {
                Page(text: "Page 5")
            }))
            pages.append(TabViewPage("Page 6", content: {
                Page(text: "Page 6")
            }))
            pages.append(TabViewPage("Page 7", content: {
                Page(text: "Page 7")
            }))
        }
    }
    
    func fixedTabs() -> some View{
        VStack{
            MaterialTab(currentIndex: $currentIndex, pages: pages, mode: .Fixed)
            TabView(selection: $currentIndex) {
                ForEach(Array(pages.enumerated()), id: \.element.title) { index, page in
                    page.content()
                        .tag(index)
                }
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .automatic))
        }
    }
    
    func scrollableTabs() -> some View{
        VStack{
            MaterialTab(currentIndex: $currentIndex, pages: pages, mode: .Scrollable)
            TabView(selection: $currentIndex) {
                ForEach(Array(pages.enumerated()), id: \.element.title) { index, page in
                    page.content()
                        .tag(index)
                }
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .automatic))
        }
    }
    
}

struct Page: View{
    let text: String
    
    var body: some View{
        Text(text)
            .font(.system(size: 32))
    }
}

#Preview {
    ContentView()
}
