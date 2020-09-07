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
  private var game : Game! = nil
  private var map : SKTileMapNode! = nil
  
  override func viewDidLoad() {
    super.viewDidLoad()
    let sview = self.view as! SKView
    let scene = SKScene(fileNamed: "GameScene")!
    scene.scaleMode = .aspectFill
    map = scene.childNode(withName: "//tileMap") as? SKTileMapNode
    game = Game(viewController: self)
    sview.presentScene(scene)
  }
  
  override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    let touch = touches.first
    let location = touch!.location(in: map)
    game.flip(x: map.tileColumnIndex(fromPosition: location), y: map.tileRowIndex(fromPosition: location))
  }
  
  @IBAction func newGame(_ sender: UIButton) {
    viewDidLoad()
  }
  
  func updateView(r: Response) {
    for i in 0...9 {
      for j in 0...9 {
        map.setTileGroup(map.tileSet.tileGroups[r.textureMap[i][j]], forColumn: i, row: j)
      }
    }
    if (r.status != 0) {
      // Loss/win message
    }
  }
}
