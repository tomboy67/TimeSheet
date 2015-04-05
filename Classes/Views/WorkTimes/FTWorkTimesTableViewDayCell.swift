//
//  FTWorkTimesTableViewDayCell.swift
//  TimeSheet
//
//  Created by TomomuraRyota on 2015/04/04.
//  Copyright (c) 2015年 TomomuraRyota. All rights reserved.
//

import UIKit

class FTWorkTimesTableViewDayCell: UITableViewCell {

    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var wdayLabel: UILabel!
    @IBOutlet weak var startTimeLabel: UILabel!
    @IBOutlet weak var endTimeLabel: UILabel!
    @IBOutlet weak var totalTimeLabel: UILabel!
    @IBOutlet weak var overtimeLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
