//
//  NewsLinkViewController.swift
//  stock_app
//
//  Created by 권민재 on 2020/08/28.
//  Copyright © 2020 gommj_Dev. All rights reserved.
//

import UIKit
import WebKit



class NewsLinkViewController: UIViewController {
    
    

    @IBOutlet weak var webView: WKWebView!
    
    var detailURL: String = ""
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("-->\(detailURL)")
        guard let url = URL(string: detailURL) else { return }
        let request = URLRequest(url: url)
        
        webView.load(request)

        // Do any additional setup after loading the view.
    }
    

    

}
