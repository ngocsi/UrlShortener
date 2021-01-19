//
//  ViewController.swift
//  URLShortener
//
//  Created by SiNguyen on 1/17/21.
//

import UIKit

class ListUrlViewController: UIViewController {
    
    //MARK: Internal Properties
    
    @IBOutlet weak var TfFillUrl: UITextField!
    @IBOutlet weak var tbvListUrlShortener: UITableView! {
        didSet {
            tbvListUrlShortener.delegate = self
            tbvListUrlShortener.dataSource = self
            tbvListUrlShortener.register(cellType: ListUrlTableViewCell.self)
            tbvListUrlShortener.separatorStyle = UITableViewCell.SeparatorStyle.none
        }
    }
    
    let viewModel = ListUrlShortenerViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUi()
        getAllUrlList()
    }
    
}

//MARK: Setup UI

extension ListUrlViewController {
    
    func setUpUi() {
        prepareViewModelObserver()
    }
    
    func checkDataListUrl() {
        if viewModel.allListUrl?.count == 0 {
            self.tbvListUrlShortener.isHidden = true
        } else {
            self.tbvListUrlShortener.isHidden = false
        }
    }
}

//MARK: Action

extension ListUrlViewController {
    
    @IBAction func clickShortUrl(_ sender: Any) {
        let urlFill = TfFillUrl.text ?? ""
        if (urlFill.validURL) {
            let url = URL(string: "\(UrlPrepix)\(urlFill)")
            do {
                let shortLink = try String(contentsOf: url!)
                viewModel.setListUrl(fullUrl: urlFill, shortenerUrl: shortLink)
            }
            catch {
               print(error)
            }
            
        } else {
            presentAlertWithTitle(title: titleAlertWarning, message: messageUrlAvalible, options: OK) { (option) in
                switch(option) {
                case OK:
                    break
                default:
                    break
                }
            }
        }
    }
}

//MARK: Private Methods

extension ListUrlViewController {
    
    private func getAllUrlList() {
        viewModel.fetchUrlList()
    }
    
    private func prepareViewModelObserver() {
        self.viewModel.urlDidChanges = { (finished, error) in
            if !error {
                self.checkDataListUrl()
                self.tbvListUrlShortener.reloadData()
            } else {
                self.presentAlertWithTitle(title: titleAlertWarning, message: messageSaveUrlError, options: OK) { (option) in
                    switch(option) {
                    case OK:
                        break
                    default:
                        break
                    }
                }
            }
        }
    }
    
}

// MARK: - UITableView Delegate And Datasource Methods
extension ListUrlViewController: UITableViewDataSource , UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.allListUrl?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(with: ListUrlTableViewCell.self, for: indexPath)
        cell.movieItem = viewModel.allListUrl?[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let url = URL(string: (viewModel.allListUrl?[indexPath.row].shortenerUrl) ?? "") else { return }
        UIApplication.shared.open(url)
        
    }
    
}
