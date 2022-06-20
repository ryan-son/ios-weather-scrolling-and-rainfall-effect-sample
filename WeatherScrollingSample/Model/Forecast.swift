//
//  Forecast.swift
//  WeatherScrollingSample
//
//  Created by Geonhee on 2022/06/21.
//

import Foundation
import struct CoreGraphics.CGFloat

struct DayForecast: Identifiable {
  var id = UUID().uuidString
  var day: String
  var celcius: CGFloat
  var image: String
}

var forecasts = [
  DayForecast(day: "Today", celcius: 23, image: "sun.min"),
  DayForecast(day: "Tue", celcius: 22, image: "cloud.sun"),
  DayForecast(day: "Wed", celcius: 20, image: "cloud.sun.bolt"),
  DayForecast(day: "Thu", celcius: 24, image: "sun.max"),
  DayForecast(day: "Fri", celcius: 26, image: "cloud.sun"),
  DayForecast(day: "Sat", celcius: 24, image: "cloud.sun"),
  DayForecast(day: "Sun", celcius: 25, image: "cloud.sun"),
  DayForecast(day: "Mon", celcius: 27, image: "sun.max"),
  DayForecast(day: "Tue", celcius: 25, image: "sun.min"),
  DayForecast(day: "Wed", celcius: 23, image: "cloud.sun.bolt"),
]
