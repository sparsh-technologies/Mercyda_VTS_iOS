//
//  Aboutuscontroller.swift
//  MERCYDA TRACK
//
//  Created by Tony on 12/07/20.
//  Copyright © 2020 Team Kochi Dev. All rights reserved.
//

import UIKit

class Aboutuscontroller: UIViewController {
    
    // MARK: - Properties
    @IBOutlet weak var termsAndConditionView: UIView!
    @IBOutlet weak var contactusView: UIView!
    @IBOutlet weak var websiteView: UIView!
    @IBOutlet weak var mainWebsiteButton: UIButton!
    
    /// view lifecycle method
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.tintColor = .white
        self.navigationController?.navigationBar.isHidden = false
        navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0.007843137255, green: 0.6588235294, blue: 0.862745098, alpha: 1)
        
        //self.navigationController?.navigationBar.titleTextAttributes = [NSF]
    }
    
    
    /// view life cycle method
    /// - Parameter animated:
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        websiteView.roundCorners(.allCorners, radius: 15)
        contactusView.roundCorners([.topLeft,.topRight], radius: 15)
        termsAndConditionView.roundCorners([.bottomLeft,.bottomRight], radius: 15)
        
    }
    
    
    /// Button  action method for contact us,privacy policy,terms and conditions etc
    /// - Parameter sender:buttontag
    //tag 100 for main url
    // tag 101 for contact us
    // tag 102 for privacy policy
    // tag 103 for terms and condition
    @IBAction func webViewDetailPAge(_ sender: UIButton) {
        
        switch sender.tag {
        case 100:
            navigate(url:AboutusPageUrls.MainUrl.rawValue)
        case 101:
            navigate(url:AboutusPageUrls.ContactUS.rawValue)
        case 102:
            navigate(url:AboutusPageUrls.MainUrl.rawValue)
        case 103:
            navigate(url:AboutusPageUrls.MainUrl.rawValue)
        default:
            printLog("Nothing")
        }
    }
    
    /// Function for naviagtion to web loading pag
    /// - Parameter url: url for the clicked button(contatus,privacy policy etc)
    func navigate(url:String){
        let story = UIStoryboard(name: StoryboardName.AboutUs.rawValue, bundle: nil)
        let vc = story.instantiateViewController(withIdentifier: StoryboardID.AboutusWebviewDetailpage.rawValue)as! AboutusWebViewController
        vc.urlString = url
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}
