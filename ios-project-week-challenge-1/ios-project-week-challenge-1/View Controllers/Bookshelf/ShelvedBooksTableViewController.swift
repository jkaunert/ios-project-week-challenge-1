import Foundation
import UIKit

class ShelvedBooksTableViewController: UITableViewController, ModelUpdateClient {
    
    var bookshelfDetails: [Book]?
    func modelDidUpdate() {
        tableView.reloadData()
    }
    
    
}
