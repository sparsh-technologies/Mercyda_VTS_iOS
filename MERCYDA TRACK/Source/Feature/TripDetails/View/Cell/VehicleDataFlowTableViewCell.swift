//
//  VehicleDataFlowTableViewCell.swift
//  MERCYDA TRACK
//
//  Created by test on 12/07/20.
//  Copyright © 2020 Team Kochi Dev. All rights reserved.
//

import UIKit

class VehicleDataFlowTableViewCell: UITableViewCell {
    
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
        if value.vehicleMode == "M" {
            modeImageView.image = UIImage.init(named: "carMove")
        }
        else {
            modeImageView.image = UIImage.init(named: "carPark")

        }
        durationLbl.text = String(hours) + "h " + String(miniutes) + "mins"
        averageSpeedLbl.text = value.averageSpeed + " km/hr"
        KMLbl.text = value.distance + " km"
        startTimeLbl.text = value.startTime
       
    }
}
