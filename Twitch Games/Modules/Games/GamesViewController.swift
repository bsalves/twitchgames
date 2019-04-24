//
//  GamesViewController.swift
//  Twitch Games
//
//  Created by Bruno Alves on 22/04/19.
//  Copyright © 2019 Bruno Alves. All rights reserved.
//

import UIKit
import PKHUD

class GamesViewController: UIViewController {
    
    // MARK: Outlets
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var collectionViewLayoutFlow: UICollectionViewFlowLayout!
    
    // MARK: Properties
    
    var games = [GameModel]()
    var selectedGame: GameModel?
    
    // MARK: Private properties
    
    private var viewModel: GamesViewModel?
    private var isLoading: Bool = false {
        didSet {
            toggleLoading()
        }
    }
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        initiateViewModel()
        isLoading = true
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToDetails" {
            let destination = segue.destination as? GameDetailViewController
            destination?.game = selectedGame
        }
    }
    
    // MARK: Private methods
    
    private func setup() {
        collectionViewLayoutFlow.scrollDirection = .vertical
        collectionViewLayoutFlow.minimumLineSpacing = 1
        collectionViewLayoutFlow.minimumInteritemSpacing = 1
        
        //
        //games.append(GameModel(gameName: "Counter Strike", imageUrl: "http://www.tompetty.com/sites/g/files/g2000007521/f/styles/photo-carousel/public/sample001.jpg?itok=0Riiujkr"))
    }
    
    private func initiateViewModel() {
        viewModel = GamesViewModel()
        viewModel?.delegate = self
    }
    
    private func toggleLoading() {
        if isLoading {
            HUD.show(HUDContentType.progress)
            return
        }
        HUD.hide()
    }
}

extension GamesViewController: GamesViewModelDelegate {
    func encodingDataReceivedError(_ error: Error?) {
        // Display error message on screen
    }
    
    func gamesDidLoad(_ games: [GameModel]) {
        self.games = games
        self.collectionView.reloadData()
        self.isLoading = false
    }
}
