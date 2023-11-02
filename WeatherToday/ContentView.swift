//
//  ContentView.swift
//  WeatherToday
//
//  Created by Viktor on 2023-10-31.
//

import SwiftUI

struct ContentView: View {
    
    var body: some View {
        TabView{
            NavigationView {
                WeatherView()
            }
            .tabItem{
                Label("Weather", systemImage: "sun.horizon")
            }
            .tag("Weather")
       
            NavigationView {
                UserProfileView()
            }
            .tabItem{
                Label("Profile2", systemImage: "person.circle")
            }
            .tag("Profile2")
        }
    }
}
    



#Preview {
    ContentView()
}
