//
//  SearchListCell.swift
//  SearchApp
//
//  Created by Rahul Kamra on 25/04/21.
//

import UIKit

class SearchTableCell: UITableViewCell {
    
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var adminName: UILabel!
    @IBOutlet weak var country: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(data: Geonames) {
        name.text = data.name
        adminName.text = data.adminCode1
        country.text = data.countryName
    }
    
}
