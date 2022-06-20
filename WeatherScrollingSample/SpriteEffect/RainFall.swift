//
//  RainFall.swift
//  WeatherScrollingSample
//
//  Created by Geonhee on 2022/06/21.
//

import SpriteKit

final class RainFall: SKScene {
  override func sceneDidLoad() {
    size = UIScreen.main.bounds.size
    scaleMode = .resizeFill
    
    anchorPoint = CGPoint(x: 0.5, y: 1)
    
    backgroundColor = .clear
    
    guard let node = SKEmitterNode(fileNamed: "RainFall.sks") else { return }
    addChild(node)
    
    node.particlePositionRange.dx = UIScreen.main.bounds.width
  }
}

final class RainFallLanding: SKScene {
  override func sceneDidLoad() {
    size = UIScreen.main.bounds.size
    scaleMode = .resizeFill
    
    let height = UIScreen.main.bounds.height
    anchorPoint = CGPoint(x: 0.5, y: (height - 5) / height)
    
    backgroundColor = .clear
    
    guard let node = SKEmitterNode(fileNamed: "RainFallLanding.sks") else { return }
    addChild(node)
    
    node.particlePositionRange.dx = UIScreen.main.bounds.width - 30
  }
}
