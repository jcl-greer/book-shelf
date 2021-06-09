//
//  ViewController.swift
//  CoolBooks
//
//  Created by user197181 on 4/1/21.
//

import UIKit

class BookListViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var nullView: UIView!
    
    let spinner = UIActivityIndicatorView(style: .large)
   
    var books: [Book] = []
    var bookService: BookService!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.bookService = BookService()
        
        self.tableView.dataSource = self
        self.tableView.delegate = self
        
        self.spinner.color = .purple
        view.addSubview(self.spinner)
        self.spinner.translatesAutoresizingMaskIntoConstraints = false
        self.spinner.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        self.spinner.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        self.spinner.startAnimating()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        guard let confirmedService = self.bookService else { return }
        
        confirmedService.getBooks(completion: { books, error in
            guard let books = books, error == nil else {
                
                self.spinner.stopAnimating()
                
                let alert = UIAlertController(title: "We've encountered an issue", message: "Unable to load books", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Okay", style: .default, handler: nil))
                self.present(alert, animated: true)
                return
        }
            self.spinner.stopAnimating()
            
        self.books = books
        self.tableView.reloadData()
            
            if self.books.count == 0 {
                self.nullView.isHidden = false
            }
        
        })
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard
            let destination = segue.destination as? DetailViewController,
            let selectedIndexPath = self.tableView.indexPathForSelectedRow,
            let confirmedCell = self.tableView.cellForRow(at: selectedIndexPath) as? BookCell
            else { return }
        let confirmedBook = confirmedCell.book
        destination.book = confirmedBook
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

