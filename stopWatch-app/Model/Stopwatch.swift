//
//  StopWatch.swift
//  stopWatch-app
//
//  Created by Mahmoud Mohammed on 8/14/18.
//  Copyright © 2018 Mahmoud Mohammed. All rights reserved.
//

import Foundation

class Stopwatch: NSObject {
    var counter: Double
    var timer: Timer
    
    override init() {
        counter = 0.0
        timer = Timer()
    }
}
