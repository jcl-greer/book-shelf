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
    
    var book: Book? {

       
        didSet {
            self.bookNameLabel.text = book?.name
            self.bookDescriptionLabel.text = book?.description
            
            let star = UIImageView(frame: CGRect(x: 0, y: 65, width: 30, height: 30))
            star.image = UIImage(systemName: "star.circle.fill")
            star.tintColor = .systemYellow
            self.accessoryView = book!.confirmedGood ? star : .none
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
