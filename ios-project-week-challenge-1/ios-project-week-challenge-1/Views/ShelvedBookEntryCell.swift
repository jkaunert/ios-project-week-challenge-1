import Foundation
import UIKit

class ShelvedBookEntryCell: UITableViewCell {
    static let reuseIdentifier = "shelved book entry cell"
    
    @IBOutlet weak var bookEntryCoverImage: UIImageView!
    
    
    @IBOutlet weak var bookTitleLabel: UILabel!
    
    
    @IBOutlet weak var authorNameLabel: UILabel!
    
}
