//
//  ViewController.swift
//  CoolBooks
//
//  Created by user197181 on 4/1/21.
//

import UIKit

class BookListViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var books: [String]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.books = ["The Devil in the Dark Water", "The Traitor Baru Cormorant", "Semiosis", "The Three-Body Problem", "Anathem", "A Memory Called Empire", "The Bird King", "Network Effect", "A Desolation Called Peace", "The Essex Serpent", "The Song of Achilles", "The 7 1/2 Deaths of Evelyn Hardcastle", "A Deadly Education", "The City We Became", "Weather"]
        
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
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "bookCell")!
        cell.textLabel?.text = self.books[indexPath.row]
        
        return cell
    }
    
    
}


extension BookListViewController: UITableViewDelegate {
    //MARK: Delegate

}

