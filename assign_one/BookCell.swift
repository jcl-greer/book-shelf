//
//  BookCell.swift
//  CoolBooks
//
//  Created by user197181 on 4/1/21.
//

import UIKit

class BookCell: UITableViewCell {

    @IBOutlet weak var bookNameLabel: UILabel!
    
    @IBOutlet weak var bookDescriptionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
