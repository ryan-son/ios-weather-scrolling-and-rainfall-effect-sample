//
//  CustomStackView.swift
//  WeatherScrollingSample
//
//  Created by Geonhee on 2022/06/20.
//

import SwiftUI

struct CustomStackView<Title: View, Content: View>: View {
  var titleView: Title
  var contentView: Content
  
  @State var topOffset: CGFloat = 0
  @State var bottomOffset: CGFloat = 0
  
  init(
    @ViewBuilder titleView: @escaping () -> Title,
    @ViewBuilder contentView: @escaping () -> Content
  ) {
    self.titleView = titleView()
    self.contentView = contentView()
  }
  
  var body: some View {
    VStack(spacing: 0) {
      titleView
        .font(.callout)
        .lineLimit(1)
        .frame(height: 38)
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.leading)
        .background(
          .ultraThinMaterial,
          in: CustomCorner(corners: bottomOffset < 38 ? .allCorners : [.topLeft, .topRight], radius: 12)
        )
        .zIndex(1)
      
      VStack {
        Divider()
        
        contentView
//          .padding(.vertical, 10)
          .padding(.horizontal)
          .padding(.vertical, 10)
      }
      .background(
        .ultraThinMaterial,
        in: CustomCorner(
          corners: [.bottomLeft, .bottomRight],
          radius: 12
        )
      )
      .offset(y: topOffset >= 120 ? 0 : topOffset - 120)
      .zIndex(0)
      .clipped()
    }
    .preferredColorScheme(.dark)
    .cornerRadius(12)
    .opacity(contentOpacity())
    .offset(y: topOffset >= 120 ? 0 : -topOffset + 120)
    .background(
      GeometryReader { proxy -> Color in
        let minY = proxy.frame(in: .global).minY
        let maxY = proxy.frame(in: .global).maxY
        
        DispatchQueue.main.async {
          self.topOffset = minY
          self.bottomOffset = maxY - 120
        }
        
        return .clear
      }
    )
    .roundCornerIfSmallerThanTitle(bottomOffset: $bottomOffset)
  }
  
  func contentOpacity() -> CGFloat {
    guard bottomOffset < 28 else { return  1 }
    
    let progress = bottomOffset / 28
    return progress
  }
}

struct CustomStackView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}

struct CornerModifier: ViewModifier {
  @Binding var bottomOffset: CGFloat
  
  func body(content: Content) -> some View {
    if bottomOffset < 38 {
      content
    } else {
      content
        .cornerRadius(12)
    }
  }
}

extension View {
  func roundCornerIfSmallerThanTitle(bottomOffset: Binding<CGFloat>) -> some View {
    modifier(CornerModifier(bottomOffset: bottomOffset))
  }
}
