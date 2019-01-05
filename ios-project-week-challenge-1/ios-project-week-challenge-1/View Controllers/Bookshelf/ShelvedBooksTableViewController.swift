import Foundation
import UIKit

class ShelvedBooksTableViewController: UITableViewController, ModelUpdateClient {
    
    var bookshelfDetails: [Item]?
    var bookDetails: Item?
    
    
//    override func numberOfSections(in tableView: UITableView) -> Int {
//        return 1
//    }
    
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
        
        //cell.bookEntryCoverImage.loadImageFrom(url: URL(string: (result.imageLink! ))!)
        cell.bookTitleLabel.text = result?.volumeInfo?.authorString
        cell.authorNameLabel.text = result?.volumeInfo?.title
        return cell
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.rightBarButtonItem?.isEnabled = false
        let activity = UIActivityIndicatorView()// for indeterminate waits
        activity.style = .gray
        activity.startAnimating()
        navigationItem.titleView = activity
        
        
        // Fetch records from Firebase and then reload the table view
        // Note: this may be significantly delayed.
//        Firebase<BookShelf>.fetchRecords { allBookshelves in
//            if let allBookshelves = allBookshelves {
//                BookshelfModel.shared.allBookshelves.contents = allBookshelves  // breaks encapsulation, hacked it instead due to time constriants
//                
//                // Comment this out to show what it looks like while waiting
//                DispatchQueue.main.async {
//                    self.tableView.reloadData()
//                    self.navigationItem.rightBarButtonItem?.isEnabled = true
//                    self.navigationItem.titleView = nil // important to be able to see custom title
//                    self.title = "My Bookshelves"
//                }
//            }
//        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //BookshelfModel.shared.delegate = self
    }
    
    func modelDidUpdate() {
        tableView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let indexPath = tableView.indexPathForSelectedRow
            else { return }
        guard let destination = segue.destination as? ShelvedBooksTableViewController
            else { return }
        
        destination.bookDetails = bookshelfDetails?[indexPath.row]
    }
    
    
    // FIXME: Update the person, update Firebase, and reload data
    override func tableView(_ tableViewPassedToUs: UITableView, didSelectRowAt indexPath: IndexPath) {
//        BookshelfModel.shared.updateBookshelf(at: indexPath) {
//            self.tableView.reloadData()
//            BookshelfModel.shared.delegate?.modelDidUpdate()
//        }
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        guard editingStyle == .delete else { return }
        
        // FIXME: Delete an item, update Firebase, update model, and reload data
//        BookshelfModel.shared.deleteBookshelf(at: indexPath) {
//            self.tableView.reloadData()
//        }
    }
    
}
