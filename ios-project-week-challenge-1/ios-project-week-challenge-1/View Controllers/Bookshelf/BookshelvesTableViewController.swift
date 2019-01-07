import Foundation
import UIKit

class BookshelvesTableViewController: UITableViewController {
    
    
    
    
    @IBAction func addNewBookshelf(_ sender: UIBarButtonItem) {
        SearchResultsController.shared.addBookshelf()
        
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
//        //Firebase.save(item: BookshelfModel.shared.allBookshelves)
//        //Firebase.save(item: newBook)
        
        
        
    }
    
    var indexForBook: Int?
    var bookShelfTitleString: String?
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //print(SearchResultsController.shared.allBookshelves.count)
        return SearchResultsController.shared.allBookshelves.count

    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
//        guard let cell = tableView.dequeueReusableCell(withIdentifier: BookshelfEntryCell.reuseIdentifier, for: indexPath) as? BookshelfEntryCell
//                       else { fatalError("Unable to dequeue entry cell") }
        let cell = tableView.dequeueReusableCell(withIdentifier: BookshelfEntryCell.reuseIdentifier, for: indexPath) as! BookshelfEntryCell
        // Configure the cell...
        let resultValue = Array(SearchResultsController.shared.allBookshelves)[indexPath.row].value
        let resultKey = Array(SearchResultsController.shared.allBookshelves)[indexPath.row].key
        
        let shelfImage: String
        // selects a random book cover from "shelved" books in that bookshelf
        if !resultValue.isEmpty {
            shelfImage = (resultValue.randomElement()?.volumeInfo?.imageLink)!
        } else {
            shelfImage = "https://via.placeholder.com/128x201?text=Cover%20Image%20Unavailable"
        }
        
        // load (random) book cover thumbnail image from URL
        cell.bookShelfCoverImage.loadImageFrom(url: URL(string: shelfImage)!)
        cell.bookShelfNameLabel.text = resultKey
        cell.bookCountLabel.text = "Shelved Books: \(String(resultValue.count))"
            return cell
        }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.rightBarButtonItem?.isEnabled = false
        let activity = UIActivityIndicatorView()// for indeterminate waits
        activity.style = .gray
        activity.startAnimating()
        navigationItem.titleView = activity
        
//        if BookshelfModel.shared.countAllBookshelves() == 0 {
//            BookshelfModel.shared.addNewBookshelf(bookshelf: BookShelf(name: "Favorites")) {
//                BookshelfModel.shared.delegate?.modelDidUpdate()
//                //Firebase.save(item: BookshelfModel.shared.allBookshelves)
//            }
//        }
        // Fetch records from Firebase and then reload the table view
//        Firebase<BookShelf>.fetchRecords { allBookshelves in
//            if let allBookshelves = allBookshelves {
//                if BookshelfModel.shared.countAllBookshelves() == 0 {
//                    let newBookshelf = BookShelf(name: "Favorites")
//                    BookshelfModel.shared.addNewBookshelf(bookshelf: newBookshelf) {
//
//                    }
//                }
//                BookshelfModel.shared.allBookshelves.contents = allBookshelves  // breaks encapsulation, hacked it instead due to time constriants
//
                // Comment this out to show what it looks like while waiting
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                    self.navigationItem.rightBarButtonItem?.isEnabled = true
                    self.navigationItem.titleView = nil // important to be able to see custom title
                    self.title = "My Bookshelves"
                }
//            }
//        }
   }
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let indexPath = tableView.indexPathForSelectedRow
            else { return }
        guard let destination = segue.destination as? ShelvedBooksTableViewController
            else { return }
        let result = Array(SearchResultsController.shared.allBookshelves)[indexPath.row].value
        destination.bookshelfDetails = result
        destination.bookShelfTitleString = Array(SearchResultsController.shared.allBookshelves)[indexPath.row].key
    }
    
    
//    // Update the records, update Firebase, and reload data
//    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
////        BookshelfModel.shared.updateBookshelf(at: indexPath) {
////            self.tableView.reloadData()
////        }
//    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {

        guard editingStyle == .delete else { return }
        
        // alert for user confirmation to delete bookshelf.
        let bookCount = Array(SearchResultsController.shared.allBookshelves)[indexPath.row].value.count
        let confirmShelfDelete = UIAlertController(title: "There are \(bookCount) books still on this bookshelf. Are you sure you want to delete it?", message: "This action cannot be undone!", preferredStyle: .actionSheet)
        
        confirmShelfDelete.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        confirmShelfDelete.addAction(UIAlertAction(title: "Yes", style: .default, handler: {action in
            
            // Delete an item, update Firebase, update model, and reload data
            let shelf = Array(SearchResultsController.shared.allBookshelves)[indexPath.row].key
            //print("delete is editingf style")
            var tempRef = SearchResultsController.shared.allBookshelves
            tempRef[shelf] = nil
            print(tempRef)
            SearchResultsController.shared.allBookshelves = tempRef
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }))
        
        self.present(confirmShelfDelete, animated: true)
        
    }
    
    
    
}

