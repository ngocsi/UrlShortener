//
//  ListUrlTableViewCell.swift
//  URLShortener
//
//  Created by SiNguyen on 1/17/21.
//

import UIKit

class ListUrlTableViewCell: UITableViewCell {
    
    //MARK: Internal Properties
    
    @IBOutlet weak var viewBackground: UIView!
    @IBOutlet weak var lbTime: UILabel!
    @IBOutlet weak var lbUrlShort: UILabel!
    @IBOutlet weak var lbUrlFull: UILabel!
    var movieItem: UrlShort? {
        didSet {
            if let movie = movieItem {
                let date = movie.date as Date
                let string = date.stringFromDate(stringFormatter: DateFormat.date.rawValue)
                lbTime.text = string
                lbUrlShort.setDifferentColor(string: "\(urlShort) \(movie.shortenerUrl)", location: 0, length: 14)
                lbUrlFull.setDifferentColor(string: "\(url) \(movie.fullUrl)", location: 0, length: 3)
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
