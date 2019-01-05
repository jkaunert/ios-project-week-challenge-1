import Foundation
import UIKit

class BookSearchDetailViewController: UIViewController {
    var bookDetails: Item?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        detailBookTitleLabel.text = bookDetails?.volumeInfo?.title
        detailBookAuthorNameLabel.text = bookDetails?.volumeInfo?.authorString
        detailBookCoverImageView.loadImageFrom(url: URL(string: (bookDetails?.volumeInfo?.imageLink ?? "https://via.placeholder.com/128x201?text=Cover%20Image%20Unavailable"))!)
    }
    
    
    @IBOutlet weak var detailBookCoverImageView: UIImageView!
    
    @IBOutlet weak var detailBookTitleLabel: UILabel!
    @IBOutlet weak var detailBookAuthorNameLabel: UILabel!
    
    
    @IBAction func addToShelf(_ sender: Any) {
        print("button clicked")
        if var tempRef = SearchResultsController.shared.allBookshelves["Favorites"] {
            tempRef.append(bookDetails!)
            print(tempRef)
            SearchResultsController.shared.allBookshelves["Favorites"] = tempRef
        }
    }
//        ShelvedBooksModel.shared.addNewBook(book: bookDetails!, to: "Favorites") {
//            BookshelfModel.shared.delegate?.modelDidUpdate()
//        }
//    }
    
    // possibly add review or summary from Google Books API, as user review
    // makes no sense on search
    
//    @IBOutlet weak var writeAReviewLabel: UILabel!
//    @IBOutlet weak var userReviewTextView: UITextView!
}
