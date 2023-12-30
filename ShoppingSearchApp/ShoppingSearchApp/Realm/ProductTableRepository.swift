//
//  ProductTableRepository.swift
//  ShoppingSearchApp
//
//  Created by 한성봉 on 2023/09/08.
//

import Foundation
import RealmSwift

// 프로토콜을 선언해 Realm 객체 관리
protocol ProductTableRepositoryType: AnyObject {
    func findFileURL() -> URL?
    func fetch() -> Results<ProductTable>
    func fetchFilter() -> Results<ProductTable>
    func createItem(_ item: ProductTable)
    func updateItem(updateValue: [String: Any])
    func deleteItem(_ item: ProductTable)
}

final class ProductTableRepository: ProductTableRepositoryType {
    
    static let shared = ProductTableRepository()
    private init() {}
    private let realm = try! Realm()
    
    // 현재 Schema migration version을 체크하는 메서드
    func checkSchemaVersion() {
        do {
            let version = try schemaVersionAtURL(realm.configuration.fileURL!)
            print("Schema Version: \(version)")
        } catch {
            print(error)
        }
    }
    
    // Document file Path 확인
    @discardableResult
    func findFileURL() -> URL? {
        guard let fileURL = realm.configuration.fileURL else { return nil }
        print(fileURL)
        return fileURL
    }
    
    // realm에 저장된 데이터 확인
    func fetch() -> Results<ProductTable> {
        let data = realm.objects(ProductTable.self).sorted(byKeyPath: "date", ascending: false)
        return data
    }
    
    // 데이터 filter
    func fetchFilter() -> Results<ProductTable> {
        let result = realm.objects(ProductTable.self)//.where {}
        return result
    }
    
    // 데이터 create
    func createItem(_ item: ProductTable) {
        do {
            try realm.write {
                realm.add(item)
                print("Realm Add Succeed")
            }
        } catch {
            print("error")
        }
    }
    
    // 데이터 update
    func updateItem(updateValue: [String: Any]) {
        do {
            try realm.write {
                realm.create(
                    ProductTable.self,
                    value: updateValue,
                    update: .modified
                )
            }
        } catch {
            print("error")
        }
    }

    // 데이터 delete
    func deleteItem(_ item: ProductTable) {
        do {
            try realm.write {
                realm.delete(item)
            }
        } catch {
            print(error)
        }
    }
}
