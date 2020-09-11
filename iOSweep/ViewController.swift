//
//  ViewController.swift
//  iOSweep
//
//  Created by Ryan Ayers on 9/6/20.
//  Copyright © 2020 Ryan Ayers. All rights reserved.
//

import SpriteKit

class ViewController: UIViewController {
  private var scene : SKScene! = nil
  private var map : SKTileMapNode! = nil
  private var game : Game! = nil
  
  @IBOutlet weak var skView: SKView!
  @IBOutlet weak var statusMessage: UILabel!
  @IBOutlet weak var playAgain: UIButton!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    scene = SKScene(fileNamed: "GameScene")!
    scene.scaleMode = .aspectFit
    map = scene.childNode(withName: "//tileMap") as? SKTileMapNode
    game = Game()
    statusMessage.isHidden = true
    playAgain.isHidden = true
    skView.presentScene(scene)
  }
  
  @IBAction func tapped(_ sender: UITapGestureRecognizer) {
    let location = sender.location(in: skView)
    let locationInScene = scene.convertPoint(fromView: location)
    let x = map.tileColumnIndex(fromPosition: locationInScene)
    let y = map.tileRowIndex(fromPosition: locationInScene)
    let response = game.flip(x: x, y: y)
    updateView(response: response)
  }
  @IBAction func longPressed(_ sender: UILongPressGestureRecognizer) {
    if (sender.state == UIGestureRecognizer.State.began) {
      let location = sender.location(in: skView)
      let locationInScene = scene.convertPoint(fromView: location)
      let x = map.tileColumnIndex(fromPosition: locationInScene)
      let y = map.tileRowIndex(fromPosition: locationInScene)
      let response = game.toggleFlag(x: x, y: y)
      updateView(response: response)
    }
  }
  @IBAction func newGame(_ sender: UIButton) {
    viewDidLoad()
  }
  
  private func updateView(response: Response) {
    for i in 0...9 {
      for j in 0...9 {
        map.setTileGroup(map.tileSet.tileGroups[response.textureMap[i][j]], forColumn: i, row: j)
      }
    }
    switch response.status {
    case -1:
      statusMessage.text = "Game over!"
      statusMessage.isHidden = false
      playAgain.isHidden = false
    case 1:
      statusMessage.text = "You win!"
      statusMessage.isHidden = false
      playAgain.isHidden = false
    default:
      break
    }
  }
}
