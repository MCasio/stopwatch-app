//
//  LapCell.swift
//  stopWatch-app
//
//  Created by Mahmoud Mohammed on 8/16/18.
//  Copyright © 2018 Mahmoud Mohammed. All rights reserved.
//

import UIKit

class LapCell: UITableViewCell {

    @IBOutlet weak var lapLbl: UILabel!
    @IBOutlet weak var valueLbl: UILabel!
    
    func configureCell(atIndexPath indexPath: IndexPath, lapArray: [String]) {
        lapLbl.text = "Lap \(lapArray.count - indexPath.row)"
        valueLbl.text = lapArray[lapArray.count - indexPath.row - 1]
    }
    
}
