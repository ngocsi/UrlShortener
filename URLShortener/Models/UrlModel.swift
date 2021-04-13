//
//  UrlModel.swift
//  URLShortener
//
//  Created by SiNguyen on 1/14/21.
//

import Foundation
import RealmSwift

class UrlShort: Object {
        @objc dynamic public private(set) var id = ""
        @objc dynamic public private(set) var date = NSDate()
        @objc dynamic public private(set) var fullUrl = ""
        @objc dynamic public private(set) var shortenerUrl = ""

    
    override class func primaryKey() -> String {
        return "id"
    }

    convenience init(fullUrl: String, shortenerUrl: String) {
        self.init()
        self.id = UUID().uuidString.lowercased()
        self.date = NSDate()
        self.fullUrl = fullUrl
        self.shortenerUrl = shortenerUrl
    }
    
    // to save realm object
    static func addUrlToRealm(fullUrl: String, shortenerUrl: String , completion: @escaping (Bool) -> Void) {
        REALM_QUEUE.sync {
            let run = UrlShort(fullUrl: fullUrl, shortenerUrl: shortenerUrl)
            do {
                let realm = try Realm(configuration: RealmConfig.runDataConfig)
                try realm.write {
                    realm.add(run)
                    try realm.commitWrite()
                }
                completion(true)
            } catch {
                debugPrint("Error adding Url to realm!")
                completion(false)
            }
        }
    }
    
    // to Fetech realm Object
    static func getAllListUrl() -> Results<UrlShort>? {
        do {
            let realm = try Realm(configuration: RealmConfig.runDataConfig)
            var runs = realm.objects(UrlShort.self)
            runs = runs.sorted(byKeyPath: "date", ascending: true)
            return runs
        } catch {
            return nil
        }
    }
}
