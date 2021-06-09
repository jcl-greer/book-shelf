//
//  CompletedViewController.swift
//  CoolBooks
//
//  Created by user197181 on 5/23/21.
//

import UIKit
import CoreData

class CompletedViewController: UIViewController {

    var completedBooks: [CompletedBook] = []
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    @IBOutlet weak var tableView: UITableView!

    
    override func viewDidLoad() {
        super.viewDidLoad()

        fetchCompletedBooks()
        
        self.tableView.dataSource = self
        self.tableView.delegate = self
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchCompletedBooks()
        self.tableView.reloadData()
    }
    
    func fetchCompletedBooks() {
        
        do {
            self.completedBooks = try self.context.fetch(CompletedBook.fetchRequest())
        } catch {
            print("failed to fetch completed book from Core Data")
        }
        
        self.tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        let numComplete = self.completedBooks.count
        
        if (numComplete == 0) {
            return "You Haven't Read any Books Yet"
        } else if (numComplete == 1) {
            return "So Far, You've Read " + String(numComplete) + " Book. Keep Going!"
        } else {
            return "So Far, You've Read " + String(numComplete) + " Books. Keep Going!"
        }
    }
}

extension CompletedViewController: UITableViewDataSource {
    //MARK: Datasource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.completedBooks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "CompletedBookCell") as! CompletedBookCell
        
        let completedBook = self.completedBooks[indexPath.row]
        
        cell.book = completedBook
        return cell
    }
}

extension CompletedViewController: UITableViewDelegate {
    //MARK: Delegate
    
    
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let title =  NSLocalizedString("Remove from Shelf", comment: "Remove From Shelf")

        let action = UIContextualAction(style: .destructive, title: title, handler: {(action, view, completionHandler) in
            
            let bookToDelete = self.completedBooks[indexPath.row]
            self.context.delete(bookToDelete)
            
            do {
                try self.context.save()

            } catch {
                print("failed to remove book from core data")
            }
            
            completionHandler(true)
            self.fetchCompletedBooks()
            })

        let configuration = UISwipeActionsConfiguration(actions: [action])
        return configuration
        
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {

        let cell = self.tableView.cellForRow(at: indexPath) as? CompletedBookCell
        let confirmedBook = cell!.book
        
        let title = confirmedBook!.isGood ? NSLocalizedString("Unfavorite", comment: "Not Favorite") : NSLocalizedString("Favorite", comment: "Favorite")

        let action = UIContextualAction(style: .normal, title: title, handler: {(action, view, completionHandler) in
            confirmedBook!.isGood = !confirmedBook!.isGood
            
            do {
                try self.context.save()
            } catch {
                print("updating entry did not work")
            }
            self.fetchCompletedBooks()

            completionHandler(true)
            })

        action.backgroundColor = confirmedBook!.isGood ? .systemPink : .systemIndigo
        
        let configuration = UISwipeActionsConfiguration(actions: [action])

        return configuration
        
    }
    
}
