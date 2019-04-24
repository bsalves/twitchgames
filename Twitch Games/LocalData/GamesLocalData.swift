//
//  GamesLocalData.swift
//  Twitch Games
//
//  Created by Bruno Alves on 24/04/19.
//  Copyright © 2019 Bruno Alves. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class GamesLocalData {
    
    func saveData(_ games: [GameModel]) {
        DispatchQueue.main.async {
            let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
            
            games.forEach({ (game) in
                
                let newGame = Games(context: context)
                newGame.gameId = Int32(game.gameId)
                newGame.gameName = game.gameName
                newGame.imageUrl = game.imageUrl
                newGame.channels = game.channels
                newGame.viewers = game.viewers
                
                (UIApplication.shared.delegate as! AppDelegate).saveContext()
            })
        }
    }
    
    @discardableResult
    func deleteData() -> Bool {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Games")
        
        do {
            let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext
            guard let data = try context?.fetch(fetchRequest) else { return false }
            data.forEach { (item) in
                let objectToDelete = item as! NSManagedObject
                context?.delete(objectToDelete)
            }

            do{
                try context?.save()
                return true
            } catch {
                return false
            }
        } catch {
            return false
        }
    }
    
    func loadAllData() -> [GameModel] {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Games")
        var games = [GameModel]()
        do {
            let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext
            let result = try context?.fetch(fetchRequest)
            for data in result as! [NSManagedObject] {
                games.append(GameModel(gameId: data.value(forKey: "gameId") as! Int,
                                       gameName: data.value(forKey: "gameName") as! String,
                                       imageUrl: data.value(forKey: "imageUrl") as! String,
                                       channels: data.value(forKey: "channels") as! String,
                                       viewers: data.value(forKey: "viewers") as! String))
            }
            return games
        } catch {
            return []
        }
    }
}
