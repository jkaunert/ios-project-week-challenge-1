import Foundation
import UIKit

class BookshelfEntryCell: UITableViewCell {
    static let reuseIdentifier = "bookshelf entry cell"
    
    @IBOutlet weak var bookShelfCoverImage: UIImageView!
    
    @IBOutlet weak var bookShelfNameLabel: UILabel!
    
    @IBOutlet weak var bookCountLabel: UILabel!
    
    
}
