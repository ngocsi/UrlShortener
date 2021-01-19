//
//  ListUrlShortenerViewModel.swift
//  URLShortener
//
//  Created by SiNguyen on 1/17/21.
//

import Foundation
import RealmSwift

protocol ListUrlShortenerViewModelProtocol {
    var urlDidChanges: ((Bool, Bool) -> Void)? { get set }
    
    func fetchUrlList()
}
class ListUrlShortenerViewModel: ListUrlShortenerViewModelProtocol {
    
    //MARK: - Internal Properties
    
    var urlDidChanges: ((Bool, Bool) -> Void)?
    
    var allListUrl: Results<UrlShort>? {
        didSet {
            self.urlDidChanges!(true, false)
        }
    }
    
    func fetchUrlList() {
        guard let allList = UrlShort.getAllListUrl() else { return }
        allListUrl = allList
    }
    
    func setListUrl(fullUrl: String, shortenerUrl: String) {
        UrlShort.addUrlToRealm(fullUrl: fullUrl, shortenerUrl: shortenerUrl) {(success) in
            if success {
                self.fetchUrlList()
            } else {
                self.urlDidChanges!(false, true)
            }
        }
    }
}
