//
//  CurrentWeatherData.swift
//  WeatherAPI
//
//  Created by Alisha on 2021/7/17.
//

import Foundation

struct CurrentWeather: Codable {
    let coord: Coordinate
    let main: CurrentMain
    let weather: [WeatherNow]
    let wind: Wind
    
    var dt: Date // 現在時間
    var sys: Sys
    var timezone: Int
    var id: Int // city ID
    var name: String
}

struct Coordinate: Codable {
    var lon: Double
    var lat: Double
}

struct CurrentMain: Codable {
    var temp: Double
    var feelsLike: Double
    var humidity: Int?
    
    enum CodingKeys: String,CodingKey {
        case temp
        case feelsLike = "feels_like"
        case humidity
    }
}

struct WeatherNow: Codable {
    var description: String
    var icon: String // 圖片編號
}

struct Wind: Codable {
    var speed: Double?
}

struct Sys: Codable{
    var sunrise: Date
    var sunset: Date
}


