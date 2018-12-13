import Foundation
import UIKit

class BookSearchEntryCell: UITableViewCell {
    static let reuseIdentifier = "book search entry cell"
    
    @IBOutlet weak var bookEntryCoverImage: UIImageView!
    
    
    @IBOutlet weak var bookTitleLabel: UILabel!
    
    
    @IBOutlet weak var authorNameLabel: UILabel!
    
}
