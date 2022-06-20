//
//  ContentView.swift
//  WeatherScrollingSample
//
//  Created by Geonhee on 2022/06/20.
//

import SwiftUI

struct ContentView: View {
  var body: some View {
    GeometryReader { proxy in
      let topEdge = proxy.safeAreaInsets.top
      
      HomeView(topEdge: topEdge)
        .ignoresSafeArea(.all, edges: .top)
    }
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
