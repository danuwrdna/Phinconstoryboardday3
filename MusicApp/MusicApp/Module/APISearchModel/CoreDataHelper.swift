import CoreData
import UIKit
import Foundation

class MusicCoreDataHelper {
    static let shared = MusicCoreDataHelper()

    private let persistentContainer: NSPersistentContainer

    private init() {
        self.persistentContainer = (UIApplication.shared.delegate as! AppDelegate).persistentContainer
    }

    func fetchHistoryMusic() -> [HistoryCoreDataModel]? {
        let context = persistentContainer.viewContext

        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "MusicEntity")

        do {
            let fetchedResults = try context.fetch(fetchRequest)
            var historyMusic: [HistoryCoreDataModel] = []

            if let musicItems = fetchedResults as? [NSManagedObject] {
                for item in musicItems {
                    if let title = item.value(forKey: "title") as? String,
                       let subtitle = item.value(forKey: "subtitle") as? String,
                       let image = item.value(forKey: "image") as? String {
                        let musicItem = HistoryCoreDataModel(title: title, subtitle: subtitle, image: image)
                        historyMusic.append(musicItem)
                    }
                }
            }

            return historyMusic
        } catch {
            print("Failed to fetch data: \(error)")
            return nil
        }
    }

    func fetchTotalHistoryMusic() -> Int {
        let context = persistentContainer.viewContext

        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "MusicEntity")

        do {
            let totalMusic = try context.count(for: fetchRequest)
            return totalMusic
        } catch {
            print("Failed to fetch total history music: \(error)")
            return 0
        }
    }

    func deleteMusicFromCoreData(title: String) {
        let context = persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "MusicEntity")
        fetchRequest.predicate = NSPredicate(format: "title == %@", title)

        do {
            let results = try context.fetch(fetchRequest)

            if let musicToDelete = results.first as? NSManagedObject {
                context.delete(musicToDelete)

                do {
                    try context.save()
                    print("Deleted music with title \(title) from Core Data")
                } catch {
                    print("Failed to save after deleting: \(error)")
                }
            }
        } catch {
            print("Error fetching music to delete: \(error)")
        }
    }

    func saveMusicToHistory(data: HistoryCoreDataModel) {
        let context = persistentContainer.viewContext

        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "MusicEntity")
        fetchRequest.predicate = NSPredicate(format: "title == %@", data.title)

        do {
            let results = try context.fetch(fetchRequest)

            if let _ = results.first as? NSManagedObject {
                // Music with the same title already exists, you can update or skip
                // For simplicity, let's just skip adding the duplicate
                print("Music with title \(data.title) already exists in history.")
            } else {
                // Music with this title doesn't exist, proceed to add it
                if let musicEntity = NSEntityDescription.entity(forEntityName: "MusicEntity", in: context) {
                    let musicItem = NSManagedObject(entity: musicEntity, insertInto: context)

                    musicItem.setValue(data.title, forKey: "title")
                    musicItem.setValue(data.subtitle, forKey: "subtitle")
                    musicItem.setValue(data.image, forKey: "image")

                    do {
                        try context.save()
                        print("Saved to history")

                        // Post a notification when the save is successful
                    } catch {
                        print("Failed to save item to history: \(error)")
                    }
                }
            }
        } catch {
            print("Error fetching existing music: \(error)")
        }
    }

    func clearCoreDataCache(completion: @escaping (Result<Void, Error>) -> Void) {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "MusicEntity")

        do {
            let entities = try context.fetch(fetchRequest)
            for entity in entities {
                context.delete(entity as! NSManagedObject)
            }
            try context.save()

            // Call the completion handler with success
            completion(.success(()))
        } catch {
            // Call the completion handler with failure and pass the error
            completion(.failure(error))
        }
    }
}
