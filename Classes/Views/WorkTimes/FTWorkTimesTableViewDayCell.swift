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
    
    var date : NSDate!
    var workTime : WorkTime?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    override func drawRect(rect: CGRect) {
        super.drawRect(rect)
        
        self.startTimeLabel.text = self.workTime?.startTime?.timeHuman()
        self.endTimeLabel.text = self.workTime?.endTime?.timeHuman()
        self.dayLabel.text = String(format: "%02d日", date.day)
        self.wdayLabel.text = "\(self.date.week().name())"
        
        self.totalTimeLabel.text = workTime?.totalTimeHuman()
        self.overtimeLabel.text = workTime?.overTimeHuman()
        
        self.dayLabel.textColor = self.date.week().color()
        self.wdayLabel.textColor = self.date.week().color()
    }

}
