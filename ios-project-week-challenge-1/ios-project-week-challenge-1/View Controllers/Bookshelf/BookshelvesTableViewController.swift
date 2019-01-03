import Foundation
import UIKit

class BookshelvesTableViewController: UITableViewController, ModelUpdateClient {
    
    
    @IBAction func addNewBookshelf(_ sender: UIBarButtonItem) {
        //test
        let newBookshelf = BookShelf(name: "Test")
        print(newBookshelf)
        let newBook = Book(recordIdentifier: "", title: "The Help", authors: ["Carl Someone"], authorString: "Carl Someone", publisher: "NoBody", publishedDate: "1994", description: "Something", pageCount: 420, averageRating: 3.9, ratingsCount: 420, imageLinks: nil, imageLink: "http://books.google.com/books/content?id=m8EltxeVkIgC&printsec=frontcover&img=1&zoom=5&edge=curl&source=gbs_api", previewLink: "http://books.google.com/books/content?id=m8EltxeVkIgC&printsec=frontcover&img=1&zoom=5&edge=curl&source=gbs_api", infoLink: "http://books.google.com/books/content?id=m8EltxeVkIgC&printsec=frontcover&img=1&zoom=5&edge=curl&source=gbs_api", subtitle: "This is some BS")
        print(newBook)
        newBookshelf.contents?.append(newBook)
        print(newBookshelf)
        BookshelfModel.shared.allBookshelves.contents?.append(newBookshelf)
        print(BookshelfModel.shared.allBookshelves.contents)
        Firebase.save(item: newBookshelf)
        //Firebase.save(item: newBook)
        modelDidUpdate()
        
        
    }
    
//    override func numberOfSections(in tableView: UITableView) -> Int {
//        return 1
//    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(BookshelfModel.shared.allBookshelves.contents?.count)
        return BookshelfModel.shared.allBookshelves.contents!.count

    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
//        guard let cell = tableView.dequeueReusableCell(withIdentifier: BookshelfEntryCell.reuseIdentifier, for: indexPath) as? BookshelfEntryCell
//                       else { fatalError("Unable to dequeue entry cell") }
        let cell = tableView.dequeueReusableCell(withIdentifier: BookshelfEntryCell.reuseIdentifier, for: indexPath) as! BookshelfEntryCell
        // Configure the cell...
        let result = BookshelfModel.shared.allBookshelves.contents![indexPath.row]
        
        // load book cover thumbnail image from URL
        cell.bookShelfCoverImage.loadImageFrom(url: URL(string: (result.contents?[0].imageLink ?? "https://via.placeholder.com/128x201?text=Cover%20Image%20Unavailable"))!)
        cell.bookShelfNameLabel.text = result.name
        //cell.bookCountLabel.text = String(result?.bookCount)
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
        Firebase<BookShelf>.fetchRecords { allBookshelves in
            if let allBookshelves = allBookshelves {
                if BookshelfModel.shared.countAllBookshelves() == 0 {
                    let newBookshelf = BookShelf(name: "Favorites")
                    BookshelfModel.shared.addNewBookshelf(bookshelf: newBookshelf) {
                        
                    }
                }
                BookshelfModel.shared.allBookshelves.contents = allBookshelves  // breaks encapsulation, hacked it instead due to time constriants
                
                // Comment this out to show what it looks like while waiting
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                    self.navigationItem.rightBarButtonItem?.isEnabled = true
                    self.navigationItem.titleView = nil // important to be able to see custom title
                    self.title = "My Bookshelves"
                }
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        BookshelfModel.shared.delegate = self
    }
    
    func modelDidUpdate() {
        tableView.reloadData()
    }
    
    var bookshelfDetails: Book?
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let indexPath = tableView.indexPathForSelectedRow
            else { return }
        guard let destination = segue.destination as? ShelvedBooksTableViewController
            else { return }
        
        destination.bookshelfDetails = BookshelfModel.shared.bookshelfAt(at: indexPath).contents
    }
    
    
    // Update the records, update Firebase, and reload data
    override func tableView(_ tableViewPassedToUs: UITableView, didSelectRowAt indexPath: IndexPath) {
        BookshelfModel.shared.updateBookshelf(at: indexPath) {
            self.tableView.reloadData()
        }
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        guard editingStyle == .delete else { return }
        
        // Delete an item, update Firebase, update model, and reload data
        BookshelfModel.shared.deleteBookshelf(at: indexPath) {
            self.tableView.reloadData()
        }
    }
    
}

