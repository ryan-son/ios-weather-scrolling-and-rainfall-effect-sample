//
//  WeatherDataView.swift
//  WeatherScrollingSample
//
//  Created by Geonhee on 2022/06/21.
//

import SwiftUI

struct WeatherDataView: View {
  var body: some View {
    VStack(spacing: 8) {
      CustomStackView(
        titleView: {
          Label("Air Quality", systemImage: "circle.hexagongrid.fill")
        },
        contentView: {
          VStack(alignment: .leading, spacing: 10) {
            Text("143 - Moderately Polluted")
              .font(.headline.bold())
            
            Text("May cause breathing discomfort for people with lung disease such as asthma and discomfort for people with heart disease, children and older adults.")
              .font(.subheadline)
              .fontWeight(.semibold)
          }
          .foregroundStyle(.white)
        }
      )
      
      HStack {
        CustomStackView(
          titleView: {
            Label("UV Index", systemImage: "sun.min")
          },
          contentView: {
            VStack(alignment: .leading, spacing: 10) {
              Text("0")
                .font(.title)
                .fontWeight(.semibold)
              
              Text("Low")
                .font(.title)
                .fontWeight(.semibold)
            }
            .foregroundStyle(.white)
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
          }
        )
        
        CustomStackView(
          titleView: {
            Label("Rainfall", systemImage: "drop.fill")
          },
          contentView: {
            VStack(alignment: .leading, spacing: 10) {
              Text("68 mm")
                .font(.title)
                .fontWeight(.semibold)
              
              Text("in last 24 hours")
                .font(.title3)
                .fontWeight(.semibold)
            }
            .foregroundStyle(.white)
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
          }
        )
      }
      .frame(maxHeight: .infinity)
      
      CustomStackView(
        titleView: {
          Label("10-Day Forecast", systemImage: "calendar")
        },
        contentView: {
          VStack(alignment: .leading, spacing: 10) {
            ForEach(forecasts) { forecast in
              VStack {
                HStack(spacing: 15) {
                  Text(forecast.day)
                    .font(.title3.bold())
                    .frame(width: 60, alignment: .leading)
                  
                  let isSunnyImage = forecast.image == "sun.min" ||
                  forecast.image ==  "sun.max"
                  
                  Image(systemName: forecast.image)
                    .font(.title3)
                    .symbolVariant(.fill)
                    .symbolRenderingMode(.palette)
                    .foregroundStyle(
                      isSunnyImage ? .yellow : .white,
                      isSunnyImage ? .white : .yellow
                    )
                    .frame(width: 30)
                  
                  Text("\(Int(forecast.celcius - 10))")
                    .font(.title3.bold())
                    .foregroundStyle(.secondary)
                    .foregroundStyle(.white)
                  
                  ZStack(alignment: .leading) {
                    Capsule()
                      .fill(.tertiary)
                      .foregroundStyle(.white)
                    
                    GeometryReader { proxy in
                      Capsule()
                        .fill(
                          .linearGradient(
                            .init(colors: [.orange, .red]),
                            startPoint: .leading,
                            endPoint: .trailing
                          )
                        )
                        .frame(width: (forecast.celcius / 40) * proxy.size.width)
                    }
                  }
                  .frame(height: 4)
                  
                  Text("\(Int(forecast.celcius))")
                    .font(.title3.bold())
                    .foregroundStyle(.white)
                }
                
                Divider()
                  .padding(.top, 13)
              }
              .padding(.vertical, 8)
            }
          }
        }
      )
    }
  }
}

struct WeatherDataView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
