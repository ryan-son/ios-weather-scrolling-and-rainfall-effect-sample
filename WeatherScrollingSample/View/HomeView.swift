//
//  HomeView.swift
//  WeatherScrollingSample
//
//  Created by Geonhee on 2022/06/20.
//

import SpriteKit
import SwiftUI

struct HomeView: View {
  @State var offset: CGFloat = 0
  var topEdge: CGFloat
  
  @State var showRain = false
  
  var body: some View {
    ZStack {
      GeometryReader { proxy in
        Image("cloud_sky")
          .resizable()
          .aspectRatio(contentMode: .fill)
          .frame(width: proxy.size.width, height: proxy.size.height)
      }
      .ignoresSafeArea()
      
      // Rain Fall View
      SpriteView(scene: RainFall(), options: [.allowsTransparency])
        .opacity(showRain ? 1 : 0)
      
      // Main View
      ScrollView(.vertical, showsIndicators: false) {
        VStack {
          // Weather Data
          VStack(alignment: .center, spacing: 5) {
            Text("Kwanak-Gu")
              .font(.system(size: 35))
              .foregroundColor(.white)
              .shadow(radius: 5)
            
            Group {
              Text("23°")
                .font(.system(size: 70))
                .fontWeight(.light)
              
              Text("Clear")
                .font(.system(size: 20))
                .fontWeight(.medium)
              
              Text("H:30° L:21°")
                .font(.system(size: 20))
                .fontWeight(.medium)
            }
            .foregroundColor(.white)
            .shadow(radius: 5)
            .opacity(titleOpacity())
          }
          .offset(y: -offset)
          .offset(y: offset > 0 ? (offset / UIScreen.main.bounds.width) * 100 : 0)
          .offset(y: titleOffset())
          
          // Custom Data View
          VStack(spacing: 8) {
            CustomStackView(
              titleView: {
                Label("Horuly Forecast", systemImage: "clock")
              },
              contentView: {
                VStack {
                  ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 15) {
                      ForecastView(time: "Now", celcius: 22, image: "cloud.moon.rain")
                      ForecastView(time: "0 AM", celcius: 22, image: "cloud.moon.rain")
                      ForecastView(time: "1 AM", celcius: 21, image: "cloud.moon.rain")
                      ForecastView(time: "2 AM", celcius: 21, image: "cloud.moon.rain")
                      ForecastView(time: "3 AM", celcius: 21, image: "cloud.moon.rain")
                      ForecastView(time: "4 AM", celcius: 21, image: "cloud.sun.rain")
                      ForecastView(time: "5 AM", celcius: 21, image: "cloud.sun.rain")
                      ForecastView(time: "6 AM", celcius: 21, image: "cloud.sun")
                      ForecastView(time: "7 AM", celcius: 22, image: "cloud.sun")
                      ForecastView(time: "8 AM", celcius: 24, image: "cloud.sun")
                    }
                  }
                }
              }
            )
            
            WeatherDataView()
          }
          .overlay(
            SpriteView(scene: RainFallLanding(), options: [.allowsTransparency])
              .offset(y: -10)
              .offset(y: -(offset + topEdge) > 105 ? -(offset + (105 + topEdge)) : 0)
              .opacity(showRain ? 1 : 0)
          )
        }
        .padding(.top, 25)
        .padding(.top, topEdge)
        .padding(.horizontal)
        .background(
          GeometryReader { proxy -> Color in
            let minY = proxy.frame(in: .global).minY
            
            DispatchQueue.main.async {
              self.offset = minY
            }
            
            return .clear
          }
        )
      }
    }
    .onAppear {
      DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) {
        withAnimation {
          showRain = true
        }
      }
    }
  }
  
  func titleOpacity() -> CGFloat {
    let progress = titleOffset() / 20
    let opacity = 1 + progress
    return opacity
  }
  
  func titleOffset() -> CGFloat {
    guard offset < 0 else { return 0 }
    
    let progress = -offset / 120
    let newOffset = (progress <= 1.0 ? progress : 1) * 20
    return -newOffset
  }
}

struct ForecastView: View {
  var time: String
  var celcius: CGFloat
  var image: String
  
  var body: some View {
    VStack(spacing: 15) {
      Text(time)
        .font(.callout.bold())
        .foregroundColor(.white)
      
      Image(systemName: image)
        .font(.title2)
        .symbolVariant(.fill)
        .symbolRenderingMode(.palette)
        .foregroundStyle(.white, .yellow)
        .frame(height: 30)
      
      Text("\(Int(celcius))°")
        .font(.body.bold())
        .foregroundColor(.white)
    }
    .padding(.horizontal, 5)
  }
}

struct HomeView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
