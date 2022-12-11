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
    
    func configure(member:Representative) {
        nameLabel.text = member.name
        locationLabel.text = "\(member.state) \(member.district)"
        phoneLabel.text = member.phone
    }
}
