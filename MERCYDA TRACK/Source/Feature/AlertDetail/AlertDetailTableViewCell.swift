//
//  Created by TeamKochi on Mid 2020.
//  Copyright © 2020 TeamKochi. All rights reserved.
//  

import UIKit

class AlertDetailTableViewCell: UITableViewCell {

    
    @IBOutlet weak var alertTypeLabel: UILabel!
    @IBOutlet weak var typeContainerView: UIView!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var typeImageView: UIImageView!
    @IBOutlet weak var timeLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func setDatas(alertDat:AlertData){
     
        addressLabel.text = alertDat.address2
        timeLabel.text = Utility.getTimeOnly(unixdateinMilliSeconds:alertDat.source_date ?? 0)
        if let alertType =   alertDat.d?.packet_type{
            alertTypeLabel.text =  alertType
            switch alertType{
            case AlertType.OverSpeed.rawValue:
                typeContainerView.backgroundColor = Utility.hexStringToUIColor("#C9A516")
                typeImageView.image = UIImage.init(named:"speedalert")
             case AlertType.WireCutAlert.rawValue:
                typeContainerView.backgroundColor = Utility.hexStringToUIColor("#5E7D62")
                typeImageView.image = UIImage.init(named:"wirecutalertimage")
             case AlertType.EmergencyAlert.rawValue:
                typeContainerView.backgroundColor = Utility.hexStringToUIColor("#DE0A0A")
                typeImageView.image = UIImage.init(named:"Alert")
            case AlertType.MainPowerRemoval.rawValue:
               typeContainerView.backgroundColor = Utility.hexStringToUIColor("#FF5E45")
                typeImageView.image = UIImage.init(named:"mainpoweralertImage")
           
            default:
               printLog("Nothing")
            }
            
            
            if alertType.contains("Overspeed Alert"){
                typeContainerView.backgroundColor = Utility.hexStringToUIColor("#C9A516")
                typeImageView.image = UIImage.init(named:"speedalert")
            }
        }
        
    }
}
