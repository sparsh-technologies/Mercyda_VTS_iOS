//
//  Created by TeamKochi on Mid 2020.
//  Copyright © 2020 TeamKochi. All rights reserved.
//  

import UIKit
import WebKit

class AboutusWebViewController: UIViewController {

    @IBOutlet weak var progressView: UIProgressView!
    @IBOutlet weak var weview: WKWebView!
    var urlString:String?
    var observation: NSKeyValueObservation?
    @IBOutlet weak var progressViewHeight: NSLayoutConstraint!
    override func viewDidLoad() {
        super.viewDidLoad()
        
     loadRequest()
    }
    

    func loadRequest(){
        
        if let url = urlString {
            if let url = URL(string: url) {
                  weview.load(URLRequest(url: url))
              }
        }
        observation = weview.observe(\WKWebView.estimatedProgress, options: .new) { _, change in
            print("Loaded: \(change)")
            
            self.progressView.progress = Float(self.weview.estimatedProgress)
            if self.progressView.progress == 1.0 {
                self.progressView.isHidden = true
                UIView.animate(withDuration: 0) {
                    self.progressViewHeight.constant = 0
                }
            }
            
        }
    }
    deinit {
        self.observation = nil
    }

}
