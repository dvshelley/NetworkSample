//
//  TableCell.swift
//  NetworkSample
//
//  Created by Daniel Shelley on 12/10/22.
//

import UIKit

class TableCell: UITableViewCell {
    static let identifier = "TableCell"
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    
    func configure(_ item:Representative) {
        nameLabel.text = item.name
        locationLabel.text = "\(item.state) \(item.district)"
        phoneLabel.text = item.phone
    }
}
