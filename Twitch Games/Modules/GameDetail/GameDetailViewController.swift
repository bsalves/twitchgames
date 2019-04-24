//
//  GameDetailViewController.swift
//  Twitch Games
//
//  Created by Bruno Alves on 22/04/19.
//  Copyright © 2019 Bruno Alves. All rights reserved.
//

import UIKit
import Reachability
import AlamofireImage
import PKHUD

class GameDetailViewController: UIViewController {
    
    // MARK: Outlets
    
    @IBOutlet weak var viewers: UILabel!
    @IBOutlet weak var channels: UILabel!
    @IBOutlet weak var cover: UIImageView!
    @IBOutlet weak var watchVideoButton: UIButton!
    
    // MARK: Properties
    
    var viewModel: GameDetailViewModel!
    var game: GameModel!
    var videoUrl: URL?
    private var reachability: Reachability?
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initiateViewModel()
        setup()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToVideo" {
            let destination = segue.destination as? StreamViewController
            destination?.videoUrl = self.videoUrl
        }
    }
    
    // MARK: Private methods
    
    private func setup() {
        self.title = self.viewModel.gameName
        self.navigationController?.title = self.viewModel.gameName
        
        self.viewers.text = self.viewModel.viewers
        self.channels.text = self.viewModel.channels
        
        if let imageUrl = URL(string: self.viewModel.cover) {
            self.cover.af_setImage(withURL: imageUrl)
        }
        
        self.registerReachability()
    }
    
    private func initiateViewModel() {
        self.viewModel = GameDetailViewModel(game: self.game, withDelegate: self)
    }
    
    private func videoWillLoad() {
        HUD.show(HUDContentType.progress)
    }
    
    private func videoDidLoad() {
        HUD.hide()
    }
    
    private func loadVideo() {
        self.videoWillLoad()
        self.viewModel.loadVideo(gameId: game.gameId)
    }
    
    // MARK: Reachability methods
    
    private func registerReachability() {
        self.reachability = Reachability.forInternetConnection()
        self.reachability?.reachableBlock = { (reach: Reachability?) -> Void in
            DispatchQueue.main.async {
                self.connectionRestaured()
            }
        }
        self.reachability?.unreachableBlock = { (reach: Reachability?) -> Void in
            DispatchQueue.main.async {
                self.connectionDown()
            }
        }
        self.reachability?.startNotifier()
    }
    
    private func connectionDown() {
        self.watchVideoButton.isEnabled = false
    }
    
    private func connectionRestaured() {
        self.watchVideoButton.isEnabled = true
    }
    
    @IBAction func initiateVideoModal(_ sender: Any) {
        if !Connectivity.isConnectedToInternet() {
            HUD.flash(HUDContentType.label("You need to be connected to watch videos!"), delay: 3)
            return
        }
        self.loadVideo()
    }
}

extension GameDetailViewController: GameDetailViewModelDelegate {
    func encodingDataReceivedError(_ error: Error?) {
        self.videoDidLoad()
        self.videoUrl = nil
        HUD.flash(HUDContentType.label("Problems when trying to load video. Please, try again!"), delay: 3)
    }
    
    func invalidUrl() {
        self.videoDidLoad()
        self.videoUrl = nil
        HUD.flash(HUDContentType.label("Problems when trying to load video. Please, try again!"), delay: 3)
    }
    
    func videoDidLoad(_ videoUrl: URL) {
        self.videoDidLoad()
        self.videoUrl = videoUrl
        self.performSegue(withIdentifier: "goToVideo", sender: nil)
    }
    
    func videosEmptyList() {
        self.videoDidLoad()
        self.videoUrl = nil
        HUD.flash(HUDContentType.label("No videos found"), delay: 1)
    }
}
