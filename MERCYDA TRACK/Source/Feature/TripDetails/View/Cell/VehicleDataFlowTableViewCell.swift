//
//  VehicleDataFlowTableViewCell.swift
//  MERCYDA TRACK
//
//  Created by test on 12/07/20.
//  Copyright © 2020 Team Kochi Dev. All rights reserved.
//

import UIKit

class VehicleDataFlowTableViewCell: UITableViewCell {
    
    @IBOutlet weak var modeLbl: UILabel!
    @IBOutlet weak var durationLbl: UILabel!
    @IBOutlet weak var averageSpeedLbl: UILabel!
    @IBOutlet weak var KMLbl: UILabel!
    @IBOutlet weak var startTimeLbl: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    func updateUI(value: TripDetailsModel) {
        var hours = Int()
        var miniutes = Int()
        
        if let hr = value.duration.hour {
            hours = hr
        }
        if let min = value.duration.minute {
            miniutes = min
        }
        durationLbl.text = String(hours) + "h " + String(miniutes) + "min"
        averageSpeedLbl.text = "Speed: " + value.averageSpeed
        KMLbl.text = value.distance + "KM"
        startTimeLbl.text = "Time :" + value.startTime
        modeLbl.text = "Mode " + value.vehicleMode
    }
}
