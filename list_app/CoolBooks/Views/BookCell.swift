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
            let star = UIImageView(frame: CGRect(x: 0, y: 65, width: 30, height: 30))
            star.image = UIImage(systemName: "star.circle.fill")
            star.tintColor = .systemYellow
            self.accessoryView = book!.confirmedGood ? star : .none
            
            DispatchQueue.global(qos: .userInitiated).async {
                if let bookImageData =
                    NSData(contentsOf: URL(string: self.book!.imageUrl)!) {
                DispatchQueue.main.async {
                    self.bookImageView.image = UIImage(data: bookImageData as! Data) }
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
