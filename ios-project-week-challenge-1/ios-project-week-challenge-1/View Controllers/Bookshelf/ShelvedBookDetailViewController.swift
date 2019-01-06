import Foundation
import UIKit


class ShelvedBookDetailViewController: UIViewController {
    
    var bookshelfDetails: [Item]?
    var bookDetails: Item?
    var indexForBook: Int?
    var bookShelfTitleString: String?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        detailBookCoverImageView.loadImageFrom(url: URL(string: (bookDetails?.volumeInfo?.imageLink ?? "https://via.placeholder.com/128x201?text=Cover%20Image%20Unavailable"))!)
        detailBookTitleLabel.text = bookDetails?.volumeInfo?.title
        detailBookAuthorNameLabel.text = bookDetails?.volumeInfo?.authorString ?? "unknown"
    }
    
    
    @IBOutlet weak var detailBookCoverImageView: UIImageView!
    
    @IBOutlet weak var detailBookTitleLabel: UILabel!
    @IBOutlet weak var detailBookAuthorNameLabel: UILabel!
    
    
    @IBOutlet weak var didReadStatusLabel: UILabel!
    @IBAction func didReadStatusSwitch(_ sender: Any) {
        
    }
    
    @IBAction func removeFromShelf(_ sender: Any) {
        let shelf = bookShelfTitleString!
        if var tempRef = SearchResultsController.shared.allBookshelves[shelf] {
            tempRef.remove(at: indexForBook!)
            //print(tempRef)
            SearchResultsController.shared.allBookshelves[shelf] = tempRef
            navigationController?.popViewController(animated: true)
            
            
        }
    }
    
    @IBOutlet weak var writeAReviewLabel: UILabel!
    @IBOutlet weak var userReviewTextView: UITextView!
    
}

