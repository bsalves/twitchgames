//
//  StreamViewController.swift
//  Twitch Games
//
//  Created by Bruno Alves on 23/04/19.
//  Copyright © 2019 Bruno Alves. All rights reserved.
//

import UIKit
import WebKit

class StreamViewController: UIViewController {

    // MARK: Outlets
    
    @IBOutlet weak var webView: WKWebView!
    
    // MARK: Internal properties
    
    var videoUrl: URL!
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setup()
    }
    
    // MARK: Actions
    
    @IBAction func exitAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    // MARK: Private methods
    
    private func setup() {
        let urlRequest = URLRequest(url: self.videoUrl)
        webView.load(urlRequest)
    }
    
}
