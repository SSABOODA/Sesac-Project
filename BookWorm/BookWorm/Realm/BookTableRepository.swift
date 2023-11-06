//
//  BookTableRepository.swift
//  BookWorm
//
//  Created by 한성봉 on 2023/09/06.
//

import Foundation
import RealmSwift

protocol BookTableRepositoryProtocol: AnyObject {
    func checkSchemaVersion()
    func findFileURL() -> URL?
    func fetch() -> Results<BookTable>
    func fetchFilter() -> Results<BookTable>
    func createItem(_ item: BookTable)
    func updateItem(updateValue: [String: Any])
    func deleteItem(_ item: BookTable)
}

class BookTableRepository: BookTableRepositoryProtocol {
    private let realm = try! Realm()
    
    func checkSchemaVersion() {
        do {
            let version = try schemaVersionAtURL(realm.configuration.fileURL!)
            print("Schema Version: \(version)")
        } catch {
            print(error)
        }
    }
    
    func findFileURL() -> URL? {
        guard let fileURL = realm.configuration.fileURL else { return nil }
        print("fileURL: \(fileURL)")
        return fileURL
    }
    
    func fetch() -> RealmSwift.Results<BookTable> {
        let data = realm.objects(BookTable.self)
        return data
    }
    
    func fetchFilter() -> RealmSwift.Results<BookTable> {
        let result = realm.objects(BookTable.self).where {
            $0.url != nil
        }
        return result
    }
    
    func createItem(_ item: BookTable) {
        do {
            try realm.write {
                realm.add(item)
                print("Realm Add Succeed")
            }
        } catch {
            print("error")
        }
    }
    
    func updateItem(
        updateValue: [String: Any]
    ) {
        do {
            try realm.write {
                realm.create(
                    BookTable.self,
                    value: updateValue,
                    update: .modified
                )
            }
        } catch {
            print("error")
        }
    }
    
    func deleteItem(_ item: BookTable) {
        do {
            try realm.write {
                realm.delete(item)
            }
        } catch {
            print(error)
        }
    }
    

}
