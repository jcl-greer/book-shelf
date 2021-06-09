//
//  ToReadViewController.swift
//  CoolBooks
//
//  Created by user197181 on 5/23/21.
//

import UIKit
import CoreData

class ToReadViewController: UIViewController {

    
    
    @IBOutlet weak var tableView: UITableView!
    
    var unreadBooks: [ToReadBook] = []
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()

        fetchUnreadBooks()
        
        self.tableView.dataSource = self
        self.tableView.delegate = self
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchUnreadBooks()
        self.tableView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard
            let destination = segue.destination as? ToReadDetailViewController,
            let selectedIndexPath = self.tableView.indexPathForSelectedRow,
            let confirmedCell = self.tableView.cellForRow(at: selectedIndexPath) as? ToReadBookCell else {return}
        
        let confirmedUnread = confirmedCell.book
        destination.book = confirmedUnread
    }
    
    func fetchUnreadBooks() {
        
        do {
            self.unreadBooks = try self.context.fetch(ToReadBook.fetchRequest())
        } catch {
            print("failed to fetch unread book from Core Data")
        }
        
        self.tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        let numUnread = self.unreadBooks.count
        
        if (numUnread == 0) {
            return "Pick Out Books to Read on the Books Tab!"
        } else if (numUnread == 1) {
            return "You Have " + String(numUnread) + " Book on Your To-Read Shelf"
        } else {
        return "You Have " + String(numUnread) + " Books on Your To-Read Shelf"
        }
    }
}


extension ToReadViewController: UITableViewDataSource {
    //MARK: Datasource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.unreadBooks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "unreadBookCell") as! ToReadBookCell
        
        let unreadBook = self.unreadBooks[indexPath.row]
        
        cell.book = unreadBook
        return cell
    }
}



extension ToReadViewController: UITableViewDelegate {
    //MARK: Delegate
    
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let title =  NSLocalizedString("Remove from Shelf", comment: "Remove From Shelf")

        let action = UIContextualAction(style: .destructive, title: title, handler: {(action, view, completionHandler) in
            
            let bookToDelete = self.unreadBooks[indexPath.row]
            self.context.delete(bookToDelete)
            
            do {
                try self.context.save()

            } catch {
                print("failed to remove book from core data")
            }
            
            completionHandler(true)
            self.fetchUnreadBooks()
            })
        action.backgroundColor = .systemPink 

        let configuration = UISwipeActionsConfiguration(actions: [action])
        return configuration
        
    }
    
    
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {

        let cell = self.tableView.cellForRow(at: indexPath) as? ToReadBookCell
        let confirmedBook = cell!.book
        
        let title = NSLocalizedString("Mark Complete", comment: "Mark Complete")

        let action = UIContextualAction(style: .normal, title: title, handler: {(action, view, completionHandler) in
            
            let finishedBook = CompletedBook(context: self.context)
            
            finishedBook.author = confirmedBook!.author
            finishedBook.bookDescription = confirmedBook!.description
            finishedBook.cover = confirmedBook!.cover
            finishedBook.genre = confirmedBook!.genre
            finishedBook.datePublished = confirmedBook!.datePublished
            finishedBook.title = confirmedBook!.title
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
