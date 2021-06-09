//
//  ViewController.swift
//  CoolBooks
//
//  Created by user197181 on 4/1/21.
//

import UIKit

class BookListViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var books: [Book] = []
    var bookService: BookService!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.bookService = BookService()
        self.books = self.bookService.getBooks()
    
        self.tableView.dataSource = self
        self.tableView.delegate = self
    }
}

extension BookListViewController: UITableViewDataSource {
    
    //MARK: DataSource
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.books.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "bookCell") as! BookCell
        
        let currentBook = self.books[indexPath.row]
        cell.book = currentBook
                
        return cell
    }
    
}

extension BookListViewController: UITableViewDelegate {
    //MARK: Delegate
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {

        let cell = self.tableView.cellForRow(at: indexPath) as? BookCell
        let confirmedBook = cell!.book
        

        let title = confirmedBook!.confirmedGood ? NSLocalizedString("Unfavorite", comment: "Not Favorite") : NSLocalizedString("Favorite", comment: "Favorite")

        let action = UIContextualAction(style: .normal, title: title, handler: {(action, view, completionHandler) in
            confirmedBook!.confirmedGood = !confirmedBook!.confirmedGood

            let star = UIImageView(frame: CGRect(x: 0, y: 65, width: 30, height: 30))
            star.image = UIImage(systemName: "star.circle.fill")
            star.tintColor = .systemYellow
            cell!.accessoryView = confirmedBook!.confirmedGood ? star : .none

            completionHandler(true)
            })

        action.backgroundColor = confirmedBook!.confirmedGood ? .systemRed : .systemGreen
        let configuration = UISwipeActionsConfiguration(actions: [action])

        return configuration
        
    }
    
    
}

