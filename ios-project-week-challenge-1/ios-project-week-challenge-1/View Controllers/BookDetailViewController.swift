import Foundation
import UIKit

class BookDetailViewController: UIViewController {
    var bookDetails: Item?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        detailBookTitleLabel.text = bookDetails?.volumeInfo.title
        detailBookAuthorNameLabel.text = bookDetails?.volumeInfo.authors![0]
    }
    
    
    @IBOutlet weak var detailBookCoverImageView: UIImageView!
    
    @IBOutlet weak var detailBookTitleLabel: UILabel!
    @IBOutlet weak var detailBookAuthorNameLabel: UILabel!
}
