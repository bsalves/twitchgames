//
//  GamesViewController.swift
//  Twitch Games
//
//  Created by Bruno Alves on 22/04/19.
//  Copyright © 2019 Bruno Alves. All rights reserved.
//

import UIKit

class GamesViewController: UIViewController {
    
    // MARK: Outlets
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var collectionViewLayoutFlow: UICollectionViewFlowLayout!
    
    // MARK: Properties
    
    var games = [GameModel]()
    var selectedGame: GameModel?
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
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
        games.append(GameModel(gameName: "Counter Strike", imageUrl: "http://www.tompetty.com/sites/g/files/g2000007521/f/styles/photo-carousel/public/sample001.jpg?itok=0Riiujkr"))
    }
    
}


