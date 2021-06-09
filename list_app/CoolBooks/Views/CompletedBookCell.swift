//
//  ToReadBookCell.swift
//  CoolBooks
//
//  Created by user197181 on 5/23/21.
//

import UIKit

class CompletedBookCell: UITableViewCell {
    
    
    @IBOutlet weak var bookNameLabel: UILabel!
    @IBOutlet weak var bookReviewLabel: UILabel!
    
    @IBOutlet weak var bookCover: UIImageView!
    
    var book: CompletedBook? {

        didSet {
            self.bookNameLabel.text = book?.title
            self.bookReviewLabel.text = book?.review
            let star = UIImageView(frame: CGRect(x: 0, y: 65, width: 30, height: 30))
            star.image = UIImage(systemName: "star.fill")
            star.tintColor = .systemIndigo
            self.accessoryView = book!.isGood ? star : .none
            self.backgroundColor = UIColor(red: 208.0 / 255, green: 210.0 / 255, blue: 240.0 / 255, alpha: 0.3)
            
            DispatchQueue.global(qos: .userInitiated).async {
                if let bookImageData =
                    NSData(contentsOf: URL(string: self.book!.cover!)!) {
                DispatchQueue.main.async {
                    self.bookCover.image = UIImage(data: bookImageData as Data)
                    self.bookCover.layer.cornerRadius = self.bookCover.frame.width / 7
                }
                }
                
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
