import Foundation
import UIKit

class BookSearchDetailViewController: UIViewController {
    var bookDetails: Item?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        detailBookTitleLabel.text = bookDetails?.volumeInfo?.title
        detailBookAuthorNameLabel.text = bookDetails?.volumeInfo?.authors![0]
    }
    
    
    @IBOutlet weak var detailBookCoverImageView: UIImageView!
    
    @IBOutlet weak var detailBookTitleLabel: UILabel!
    @IBOutlet weak var detailBookAuthorNameLabel: UILabel!
    
    
    @IBAction func addToShelf(_ sender: Any) {
    }
    
    // possibly add review or summary from Google Books API, as user review
    // makes no sense on search
    
//    @IBOutlet weak var writeAReviewLabel: UILabel!
//    @IBOutlet weak var userReviewTextView: UITextView!
}
