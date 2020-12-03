//
//  ContentView.swift
//  swiftUI-Simple-CMS
//
//  Created by Waleerat Gottlieb on 2020-12-02.
//

import SwiftUI

import SwiftUI

struct HomeView: View {
    let screen = UIScreen.main.bounds
    
    var body: some View {
            VStack {
                TabView {
                   
                    CategoryIndexView()
                        .tabItem {
                            Image(systemName: "command")
                            Text("Category")
                        }.tag(0)
                    
                    ProductIndexView()
                        .tabItem {
                            Image(systemName: "command")
                            Text("Product")
                        }.tag(1)
                    
                    Text("View 3")
                        .tabItem {
                            Image(systemName: "command")
                            Text("Coming Soon")
                        }.tag(2)
                    
                    Text("View 4")
                        .tabItem {
                            Image(systemName: "command")
                            Text("Downloads")
                        }.tag(3)
                }
                .accentColor(Color.blue)
            }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.init("myBackground")
                .edgesIgnoringSafeArea(.all)
            HomeView() 
        }
    }
}
