import Foundation
import UIKit

class ShelvedBooksTableViewController: UITableViewController {
    
    
    var bookshelfDetails: [Item]?
    var bookDetails: Item?
    var bookShelfTitleString: String?
    var indexForBook: Int?
    var dataReceived: [Item]?
    var shelf: String?
    
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (bookshelfDetails?.count)!
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //        guard let cell = tableView.dequeueReusableCell(withIdentifier: BookshelfEntryCell.reuseIdentifier, for: indexPath) as? BookshelfEntryCell
        //                       else { fatalError("Unable to dequeue entry cell") }
        let cell = tableView.dequeueReusableCell(withIdentifier: ShelvedBookEntryCell.reuseIdentifier, for: indexPath) as! ShelvedBookEntryCell
        // Configure the cell...
        let result = bookshelfDetails?[indexPath.row]
        
        
        // load book cover thumbnail image from URL
        
        cell.bookEntryCoverImage.loadImageFrom(url: URL(string: (result?.volumeInfo?.imageLink ?? "https://via.placeholder.com/128x201?text=Cover%20Image%20Unavailable"))!)
        cell.bookTitleLabel.text = result?.volumeInfo?.authorString
        cell.authorNameLabel.text = result?.volumeInfo?.title
        return cell
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        shelf = bookShelfTitleString
        bookshelfDetails = SearchResultsController.shared.allBookshelves[shelf!]
        self.tableView.reloadData()
        navigationItem.rightBarButtonItem?.isEnabled = false
        let activity = UIActivityIndicatorView()// for indeterminate waits
        activity.style = .gray
        activity.startAnimating()
        navigationItem.titleView = activity

        //}
        // Fetch records from Firebase and then reload the table view
        // Note: this may be significantly delayed.
//        Firebase<BookShelf>.fetchRecords { allBookshelves in
//            if let allBookshelves = allBookshelves {
//                SearchResultsController.shared.allBookshelves = allBookshelves  // breaks encapsulation, hacked it instead due to time constriants

                 //Comment this out to show what it looks like while waiting
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                    self.navigationItem.rightBarButtonItem?.isEnabled = true
                    self.navigationItem.titleView = nil // important to be able to see custom title
                    self.title = self.bookShelfTitleString
                }
            }
//        }
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        DispatchQueue.main.async {
            print("view did load")
            self.tableView.reloadData()
            }
        
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let indexPath = tableView.indexPathForSelectedRow
            else { return }
        guard let destination = segue.destination as? ShelvedBookDetailViewController
            else { return }
        
        destination.bookDetails = bookshelfDetails?[indexPath.row]
        destination.indexForBook = indexPath.row
        destination.bookshelfDetails = bookshelfDetails
        destination.bookShelfTitleString = bookShelfTitleString
    }
    
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            // FIXME: Delete an item, update Firebase, update model, and reload data
            if var tempRef = SearchResultsController.shared.allBookshelves["Favorites"] {
                tempRef.remove(at: indexPath.row)
                print(tempRef)
                bookshelfDetails?.remove(at: indexPath.row)
                print(bookshelfDetails!)
                SearchResultsController.shared.allBookshelves["Favorites"] = tempRef
                tableView.deleteRows(at: [indexPath], with: .fade)
                
                        DispatchQueue.main.async {
                            self.tableView.reloadData()
                        }
            }
        }
        
    }
    
}
