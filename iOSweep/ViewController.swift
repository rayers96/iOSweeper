//
//  ViewController.swift
//  iOSweep
//
//  Created by Ryan Ayers on 9/6/20.
//  Copyright © 2020 Ryan Ayers. All rights reserved.
//

import UIKit
import SpriteKit

class ViewController: UIViewController {
  
  override func viewDidLoad()
  {
    super.viewDidLoad()
    
    var g = Game()
    
    // Display tile map filled w/ stone
    let sview = self.view as! SKView
    let scene = SKScene(fileNamed: "GameScene")!
    scene.scaleMode = .aspectFill
    let map = scene.childNode(withName: "//tileMap") as! SKTileMapNode
    map.fill(with: map.tileSet.tileGroups[0])
    sview.presentScene(scene)
  }
  
  override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
  }
  
  private func updateView() {
  }
}
