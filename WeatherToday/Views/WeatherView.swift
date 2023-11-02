//
//  WeatherView.swift
//  WeatherToday
//
//  Created by Viktor on 2023-11-01.
//

import SwiftUI


struct WeatherView: View {
    @State private var weather: Weather?
    @State private var city: String = ""

    func getWeather() {
        API().loadData(city: self.city) { weather in
            DispatchQueue.main.async {
                self.weather = weather
            }
        }
    }

    var body: some View {
        NavigationStack {
            VStack(alignment: .leading) {
                TextField("Enter city", text: $city)
                    .multilineTextAlignment(.center)
                    .font(Font.title.weight(.light))
                    .padding()

                HStack {
                    Spacer()
                    Button(action: getWeather) {
                        Text("Get Weather")
                            .padding()
                            .overlay(
                                RoundedRectangle(cornerRadius: 50)
                                    .stroke(Color.white, lineWidth: 2)
                            )
                    }
                    .font(.title2)
                    Spacer()
                }

                // Display weather information if available
                if let weather = weather {
                    Text("City: \(city)")
                    Text("Temperature: \(weather.temp)°C")
                    // Add more weather properties as needed
                } else {
                    // Display a message if no weather data is available
                    Text("No weather data available")
                        .foregroundColor(.red)
                }
            }
            .padding(30.0)
         
            }
            .navigationTitle("Weather")
         
            }
        }
    




#Preview {
    WeatherView()
}
