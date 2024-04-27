
import UIKit
import CoreData

class DataPersistenceManager {
    
    static let shared = DataPersistenceManager()

    enum DataBaseError: Error {
        case failedToSaveData
        case failedToFetchData
        case failedToDeleteData
    }
    
    func saveLeaguesFavoritesFromDatabase(model: ResponseLeague, completion: @escaping (Result<Void, Error>) -> Void) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return completion(.failure(DataBaseError.failedToSaveData))
        }
        let context = appDelegate.persistentContainer.viewContext
        let item = TitleItem(context: context)
        item.id = Int64(model.league?.id ?? 0)
        item.name = model.league?.name
        item.logo = model.league?.logo
        
        do {
            try context.save()
            completion(.success(()))
        } catch {
            completion(.failure(DataBaseError.failedToSaveData))
        }
    }
    
    func fetchingFavoritesLeaguesFromDataBase(completion: @escaping (Result<[TitleItem], Error>) -> Void) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return completion(.failure(DataBaseError.failedToSaveData))
        }
        let context = appDelegate.persistentContainer.viewContext
        
        let request: NSFetchRequest<TitleItem>
        request = TitleItem.fetchRequest()
        
        do {
            let leagues = try context.fetch(request)
            completion(.success(leagues))
        } catch {
            print(DataBaseError.failedToFetchData)
        }
    }
    
    func deleteFavoritesLeaguFromDatabase(model: TitleItem, completion: @escaping (Result<Void, Error>) -> Void) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return completion(.failure(DataBaseError.failedToSaveData))
        }
        let context = appDelegate.persistentContainer.viewContext
        context.delete(model)
        do {
            try context.save()
            completion(.success(()))
        } catch{
            completion(.failure(DataBaseError.failedToDeleteData))
        }
    }
}

