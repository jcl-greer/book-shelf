//
//  BookCell.swift
//  CoolBooks
//
//  Created by user197181 on 4/1/21.
//

import UIKit

class BookCell: UITableViewCell {

    
    @IBOutlet weak var bookNameLabel: UILabel!
    @IBOutlet weak var bookAuthorLabel: UILabel!
    @IBOutlet weak var bookImageView: UIImageView!
    
    var book: Book? {

        didSet {
            self.bookNameLabel.text = book?.name
            self.bookAuthorLabel.text = book?.author
            self.contentView.backgroundColor = UIColor(red: 208.0 / 255, green: 210.0 / 255, blue: 240.0 / 255, alpha: 0.3)
            
            DispatchQueue.global(qos: .userInitiated).async {
                if let bookImageData =
                    NSData(contentsOf: URL(string: self.book!.imageUrl)!) {
                DispatchQueue.main.async {
                    self.bookImageView.image = UIImage(data: bookImageData as Data)
                    self.bookImageView.layer.cornerRadius = self.bookImageView.frame.width / 7
                    }
                }
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
