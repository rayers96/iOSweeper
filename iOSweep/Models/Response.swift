//
//  Response.swift
//  iOSweep
//
//  Created by Ryan Ayers on 9/7/20.
//  Copyright © 2020 Ryan Ayers. All rights reserved.
//

import Foundation

struct Response {
  var textureMap : [[Int]] = Array(repeating: Array(repeating: 9, count: 10), count: 10)
  var status : Int = 0 // 0 = continue, 1 = win, -1 lose
}
