import Foundation
import UIKit

class BookShelfController {
    
    func createShelf(name: String, imageLink: String) -> BookShelf {
        
        return BookShelf(name: name, imageLink: imageLink)
    }
    
    func addBookToBookshelf(){}
    
}
