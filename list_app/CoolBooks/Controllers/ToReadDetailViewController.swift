//
//  DetailViewController.swift
//  CoolBooks
//
//  Created by user197181 on 4/16/21.
//

import UIKit

class ToReadDetailViewController: UIViewController {
    
    var book: ToReadBook!
    
    
    @IBOutlet weak var bookTitle: UILabel!
    @IBOutlet weak var bookAuthor: UILabel!
    @IBOutlet weak var bookGenre: UILabel!
    @IBOutlet weak var datePublished: UILabel!
    @IBOutlet weak var bookDescription: UILabel!
    
 
    @IBOutlet weak var bookCover: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.setNavigationBarHidden(false, animated: true)

        self.view.backgroundColor = UIColor(red: 208/255, green: 210/255, blue: 240/255, alpha: 1)
        
        self.bookTitle.text = book.title
        self.bookDescription.text = book.bookDescription
        self.bookGenre.text = book.genre
        self.bookAuthor.text = book.author
        self.datePublished.text = "Date Published: " + book.datePublished!

        DispatchQueue.global(qos: .userInitiated).async {
            let bookImageData =
                NSData(contentsOf: URL(string: self.book!.cover!)!)
            DispatchQueue.main.async {
                self.bookCover.image = UIImage(data: bookImageData! as Data)
                self.bookCover.layer.cornerRadius = self.bookCover.frame.width / 10
            }
        }
    }
}
