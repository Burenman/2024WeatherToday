//
//  Weather.swift
//  WeatherToday
//
//  Created by Viktor on 2023-10-31.
//

import Foundation

struct Weather: Identifiable, Codable {
    let id = UUID()
    var temp: Int
    var humidity: Int
    var sunset: Int
    var sunrise: Int
    var min_temp: Int
    var max_temp: Int
    var feels_like: Int
    var wind_speed: Double
}

let apiKey = Secret.apiKey

class API : ObservableObject {
    @Published var weather: Weather?
    
    func loadData(city: String, completion: @escaping (Weather?) -> ()) {
        let city = city.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        let url = URL(string: "https://api.api-ninjas.com/v1/weather?city="+city!)!
        var request = URLRequest(url: url)
        request.setValue( apiKey, forHTTPHeaderField: "X-Api-Key")
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data {
                do {
                    let weather = try JSONDecoder().decode(Weather.self, from: data)
                    completion(weather)
                } catch {
                    print("Error decoding weather data: \(error)")
                    completion(nil)
                }
            } else {
                print("No data received from the server")
                completion(nil)
            }
        }.resume()
    }
}
