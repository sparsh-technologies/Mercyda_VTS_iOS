//
//  VehicleDataFlowTableViewCell.swift
//  MERCYDA TRACK
//
//  Created by test on 12/07/20.
//  Copyright © 2020 Team Kochi Dev. All rights reserved.
//

import UIKit

class VehicleDataFlowTableViewCell: UITableViewCell {
    
    @IBOutlet weak var waitImageView: UIImageView!
    @IBOutlet weak var spdTimeImageView: UIImageView!
    @IBOutlet weak var topLineView: UIView!
    @IBOutlet weak var modeImageView: UIImageView!
    @IBOutlet weak var modeView: UIView!
    @IBOutlet weak var durationLbl: UILabel!
    @IBOutlet weak var averageSpeedLbl: UILabel!
    @IBOutlet weak var KMLbl: UILabel!
    @IBOutlet weak var bottomLineView: UIView!
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
        modeView.layer.cornerRadius = modeView.frame.height/2
        modeView.layer.borderWidth = 1
        modeView.layer.borderColor = UIColor.black.cgColor
        modeView.backgroundColor = UIColor.white
        var hours = Int()
        var miniutes = Int()
        
        if let hr = value.duration.hour {
            hours = hr
        }
        if let min = value.duration.minute {
            miniutes = min
        }
        startTimeLbl.text = value.startTime
        if value.vehicleMode == "M" {
            spdTimeImageView.image = UIImage.init(named: "speed_16")
            modeImageView.image = UIImage.init(named: "carMove")
            KMLbl.text = value.distance + " km"
            if hours == 0 {
                durationLbl.text = String(miniutes) + " mins"
            } else {
                durationLbl.text = String(hours) + " h " + String(miniutes) + " mins"
            }
            averageSpeedLbl.text = value.averageSpeed + " km/hr"
            durationLbl.isHidden = false
            waitImageView.isHidden = false
        }
        else {
            spdTimeImageView.image = UIImage.init(named: "time_sm")
            durationLbl.isHidden = true
            waitImageView.isHidden = true
            modeImageView.image = UIImage.init(named: "carPark")
            KMLbl.text = value.placeName
            if hours == 0 {
                averageSpeedLbl.text = String(miniutes) + " mins"
            } else {
                averageSpeedLbl.text = String(hours) + " h " + String(miniutes) + " mins"
            }
        }
            
    }
}
