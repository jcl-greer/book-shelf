//
//  DetailViewController.swift
//  CoolBooks
//
//  Created by user197181 on 4/16/21.
//

import UIKit

class DetailViewController: UIViewController {
    
    var book: Book!
    
    
    @IBOutlet weak var coverImage: UIImageView!
    @IBOutlet weak var bookTitle: UILabel!
    @IBOutlet weak var bookDescription: UILabel!
    @IBOutlet weak var bookGenre: UILabel!
    @IBOutlet weak var bookAuthor: UILabel!
    @IBOutlet weak var bookYear: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.setNavigationBarHidden(false, animated: true)
        
        print(book!)
        
        self.bookTitle.text = book.name
        self.bookDescription.text = book.description
        self.bookGenre.text = book.genre
        self.bookAuthor.text = book.author
        self.bookYear.text = "Date Published: " + book.datePublished
        
        DispatchQueue.global(qos: .userInitiated).async {
            let bookImageData =
                NSData(contentsOf: URL(string: self.book!.imageUrl)!)
            DispatchQueue.main.async {
                self.coverImage.image = UIImage(data: bookImageData! as Data)
                self.coverImage.layer.cornerRadius = self.coverImage.frame.width / 10
        
            }
        }
    }
}
