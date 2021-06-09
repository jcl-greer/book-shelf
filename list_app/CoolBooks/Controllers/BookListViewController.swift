//
//  ViewController.swift
//  CoolBooks
//
//  Created by user197181 on 4/1/21.
//

import UIKit
import CoreData

class BookListViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var nullView: UIView!
    
    @IBOutlet weak var sortButton: UIBarButtonItem!
    
    
    let spinner = UIActivityIndicatorView(style: .large)
    
    let searchController = UISearchController(searchResultsController: nil)
   
    var books: [Book] = []
    var filteredBooks: [Book] = []
    var bookService: BookService!
    var sortAscending = false
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.bookService = BookService()
        
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.tableView.backgroundView = self.nullView
        self.sortButton.title = "Sort Asc"
        
        self.spinner.color = .purple
        view.addSubview(self.spinner)
        self.spinner.translatesAutoresizingMaskIntoConstraints = false
        self.spinner.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        self.spinner.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        self.spinner.startAnimating()
        
        navigationController?.navigationBar.backgroundColor = UIColor.systemPink.withAlphaComponent(0.6)
        navigationController?.navigationBar.barTintColor = UIColor.systemPink.withAlphaComponent(0.7)
        
        
        //MARK: Search Bar
        self.searchController.searchResultsUpdater = self
        self.searchController.obscuresBackgroundDuringPresentation = false
        self.searchController.searchBar.searchTextField.attributedPlaceholder =  NSAttributedString.init(string: "Search for books", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        self.searchController.searchBar.delegate = self
        self.searchController.searchBar.searchTextField.backgroundColor = .systemIndigo
        navigationItem.searchController = self.searchController
        self.searchController.searchBar.searchTextField.textColor = .white
        navigationItem.hidesSearchBarWhenScrolling = false
        self.definesPresentationContext = true
        
        
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
        self.filteredBooks = books
        self.tableView.reloadData()
            
            if self.books.count == 0 {
                self.nullView.isHidden = false
            }
        
        })
    }
    
    
    @IBAction func sortBooks(_ sender: Any) {
        if (self.sortAscending == false) {
            self.filteredBooks = self.filteredBooks.sorted(by: {$0.name < $1.name})
            self.sortAscending = true
            self.sortButton.title = "Sort Desc"
        } else {
            self.filteredBooks = self.filteredBooks.sorted(by: {$0.name > $1.name})
            self.sortAscending = false
            self.sortButton.title = "Sort Asc"
        }
        self.tableView.reloadData()
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
    
    
    func filterBookList(searchTerm: String) {
        if searchTerm.count > 0 {
            self.filteredBooks = self.books
            
            let filteredResults = self.filteredBooks.filter {$0.name.replacingOccurrences(of: " ", with: "").lowercased().contains(searchTerm.replacingOccurrences(of: " ", with: "").lowercased())}

        self.filteredBooks = filteredResults
        tableView.reloadData()
            
        }
    }
}

//


extension BookListViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        
        if let searchText = searchController.searchBar.text {
            filterBookList(searchTerm: searchText)
        }
    }
}

extension BookListViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchController.isActive = false
        if let searchText = searchBar.text {
            filterBookList(searchTerm: searchText)
        }
        
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        
        self.searchController.isActive = false
        self.filteredBooks = self.books
        self.tableView.reloadData()
    }
    
}

extension BookListViewController: UITableViewDataSource {
    
    //MARK: DataSource
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.filteredBooks.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "bookCell") as! BookCell
        
        let currentBook = self.filteredBooks[indexPath.row]
        cell.book = currentBook
                
        return cell
    }
    
}

extension BookListViewController: UITableViewDelegate {
    //MARK: Delegate
    
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {

        let cell = self.tableView.cellForRow(at: indexPath) as? BookCell
        let confirmedBook = cell!.book
        
        let title = NSLocalizedString("Add to To-Read Shelf", comment: "Add to To-Read Shelf")
        
        self.context.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy

        let action = UIContextualAction(style: .normal, title: title, handler: {(action, view, completionHandler) in
            
            let newUnread = ToReadBook(context: self.context)
            
            newUnread.author = confirmedBook!.author
            newUnread.bookDescription = confirmedBook!.description
            newUnread.cover = confirmedBook!.imageUrl
            newUnread.genre = confirmedBook!.genre
            newUnread.datePublished = confirmedBook!.datePublished
            newUnread.title = confirmedBook!.name
            newUnread.isGood = false
            
            do {
                try self.context.save()
                let alert = UIAlertController(title: "Added Book to To-Read Shelf", message: "", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Nice!", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
                print("saved: " + confirmedBook!.name)
            } catch {
                print("failed to save book to core data")
            }

            completionHandler(true)
            })

        action.backgroundColor = .systemPurple
        let configuration = UISwipeActionsConfiguration(actions: [action])

        return configuration
        
    }
    
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {

        let cell = self.tableView.cellForRow(at: indexPath) as? BookCell
        let confirmedBook = cell!.book
        
        let title = NSLocalizedString("Add to Completed Shelf", comment: "Add to Completed Shelf")

        let action = UIContextualAction(style: .normal, title: title, handler: {(action, view, completionHandler) in
            
            let finishedBook = CompletedBook(context: self.context)
            
            finishedBook.author = confirmedBook!.author
            finishedBook.bookDescription = confirmedBook!.description
            finishedBook.cover = confirmedBook!.imageUrl
            finishedBook.genre = confirmedBook!.genre
            finishedBook.datePublished = confirmedBook!.datePublished
            finishedBook.title = confirmedBook!.name
            finishedBook.isGood = false
            finishedBook.review = "no thoughts..."
            
            let alert = UIAlertController(title: "", message: "Add to Completed Shelf", preferredStyle: .alert)
            alert.addTextField()
                
            let submitReview = UIAlertAction(title: "What Did You Think?", style: .default) { (action) in
                let textField = alert.textFields![0]
                
                if (textField.text != "") {
                finishedBook.review = textField.text
                }
                do {
                    try self.context.save()
                    print("saved: " + confirmedBook!.name)
                    
                } catch {
                    
                    print("failed to save book to core data")
                }
            }
            
            alert.addAction(submitReview)
            self.present(alert, animated: true, completion: nil)
            completionHandler(true)
            })

        action.backgroundColor = .systemIndigo
        let configuration = UISwipeActionsConfiguration(actions: [action])

        return configuration
        
    }
    
    
    
    
    
}

