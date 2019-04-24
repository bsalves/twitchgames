//
//  GamesViewController.swift
//  Twitch Games
//
//  Created by Bruno Alves on 22/04/19.
//  Copyright © 2019 Bruno Alves. All rights reserved.
//

import UIKit
import Reachability
import PKHUD

class GamesViewController: UIViewController {
    
    // MARK: Outlets
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var collectionViewLayoutFlow: UICollectionViewFlowLayout!
    @IBOutlet weak var errorLabel: UILabel!
    
    // MARK: Properties
    
    var games = [GameModel]()
    var selectedGame: GameModel?
    
    // MARK: Private properties
    
    private var viewModel: GamesViewModel!
    private var reachability: Reachability?
    private lazy var refresher = UIRefreshControl()
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewModel = GamesViewModel(delegate: self)
        setup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if !Connectivity.isConnectedToInternet() {
            HUD.hide()
            self.connectionDown()
        }
        
        if self.games.count > 0 {
            errorLabel.isHidden = true
        } else {
            errorLabel.isHidden = false
            errorLabel.text = "Nothing here!"
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToDetails" {
            let destination = segue.destination as? GameDetailViewController
            destination?.game = selectedGame
        }
    }
    
    // MARK: Private methods
    
    private func setup() {
        errorLabel.isHidden = false
        self.showLoading()
        collectionViewLayoutFlow.scrollDirection = .vertical
        collectionViewLayoutFlow.minimumLineSpacing = 1
        collectionViewLayoutFlow.minimumInteritemSpacing = 1
        self.registerRefresher()
        self.registerReachability()
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
        self.collectionView.refreshControl = nil
    }
    
    private func connectionRestaured() {
        self.registerRefresher()
        if games.isEmpty {
            self.refreshGames()
        }
    }
    
    // MARK: Data handler methods
    
    private func asyncLoadFinished() {
        HUD.hide()
        self.refresher.endRefreshing()
    }
    
    @objc private func refreshGames() {
        if Connectivity.isConnectedToInternet() {
            self.showLoading()
            self.viewModel.refreshGames()
        }
    }
    
    private func gamesLoaded() {
        self.collectionView.reloadData()
    }
    
    private func showLoading() {
        HUD.show(HUDContentType.progress)
    }
    
    // MARK: RefresherUI methods
    
    private func registerRefresher() {
        self.collectionView.refreshControl = self.refresher
        refresher.addTarget(self, action: #selector(self.refreshGames), for: .valueChanged)
    }
}

extension GamesViewController: GamesViewModelDelegate {
    func connectionFails() {
        errorLabel.isHidden = false
        errorLabel.text = "Ooops!\nConnection is down!"
        self.asyncLoadFinished()
    }
    
    func encodingDataReceivedError(_ error: Error?) {
        errorLabel.isHidden = false
        errorLabel.text = "Ooops!\nError while trying to get games."
        self.asyncLoadFinished()
    }
    
    func gamesDidLoad(_ games: [GameModel]) {
        self.games = games
        if self.games.count > 0 {
            errorLabel.isHidden = true
        }
        self.gamesLoaded()
        self.asyncLoadFinished()
    }
}
