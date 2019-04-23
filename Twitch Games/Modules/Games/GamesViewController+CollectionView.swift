//
//  GamesViewController+CollectionView.swift
//  Twitch Games
//
//  Created by Bruno Alves on 22/04/19.
//  Copyright © 2019 Bruno Alves. All rights reserved.
//

import UIKit

extension GamesViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return games.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GameCollectionViewCell", for: indexPath) as? GameCollectionViewCell
        cell?.gameName.text = games[indexPath.row].gameName
        if let url = URL(string: games[indexPath.row].imageUrl) {
            cell?.cover.af_setImage(withURL: url)
        }
        
        return cell ?? UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.selectedGame = games[indexPath.row]
        self.performSegue(withIdentifier: "goToDetails", sender: self)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var width: CGFloat
        if collectionView.bounds.width < collectionView.bounds.height {
            width = (collectionView.bounds.width / 2) - 1
        } else {
            width = (collectionView.bounds.width / 5) - 1
        }
        
        let height = width * 1.5
        return CGSize(width: width, height: height)
    }
}
