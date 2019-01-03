import Foundation
import UIKit

class ShelvedBookDetailViewController: UIViewController {
    
    var bookDetails: Book!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        detailBookTitleLabel.text = bookDetails?.title
        detailBookAuthorNameLabel.text = bookDetails?.authors?[0] ?? "unknown"
    }
    
    
    @IBOutlet weak var detailBookCoverImageView: UIImageView!
    
    @IBOutlet weak var detailBookTitleLabel: UILabel!
    @IBOutlet weak var detailBookAuthorNameLabel: UILabel!
    
    
    @IBOutlet weak var didReadStatusLabel: UILabel!
    @IBAction func didReadStatusSwitch(_ sender: Any) {
        
    }
    
    @IBAction func removeFromShelf(_ sender: Any) {
        
    }
    
    @IBOutlet weak var writeAReviewLabel: UILabel!
    @IBOutlet weak var userReviewTextView: UITextView!
    
}

