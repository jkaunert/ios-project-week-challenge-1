import Foundation
import UIKit


class BookshelfModel {
    static let shared = BookshelfModel()
    private init() {}
    var delegate: ModelUpdateClient?
    
   
    var allBookshelves = AllBookShelves()
    
    // MARK: bookshelf methods
    func countAllBookshelves() -> Int {
        return allBookshelves.contents?.count ?? 0
    }
    
    func bookshelf(forIndex index: Int) -> BookShelf {
        return (allBookshelves.contents?[index])!
    }
    
    func bookshelfAt(at indexPath: IndexPath) -> BookShelf {
        return (allBookshelves.contents?[indexPath.row])!
    }
    
    // MARK: Bookshelf Core Database Management Methods
    
    func addNewBookshelf(bookshelf: BookShelf, completion: @escaping () -> Void) {
        // FIXME:
        let bookshelf = bookshelf
        // local
        allBookshelves.contents?.append(bookshelf)
        // remote
        Firebase<BookShelf>.save(item: bookshelf) { success in
            guard success else { return }
            DispatchQueue.main.async { completion() }
        }
        
    }
    func deleteBookshelf(at indexPath: IndexPath, completion: @escaping () -> Void) {
        // FIXME:
        // local
        let bookshelf = allBookshelves.contents?[indexPath.row]
        allBookshelves.contents?.remove(at: indexPath.row)
        // remote
        Firebase<BookShelf>.delete(item: bookshelf!) { success in
            guard success else { return }
            DispatchQueue.main.async { completion() }
        }
    }
    func updateBookshelf(at indexPath: IndexPath, completion: @escaping () -> Void) {
        // FIXME:
        // local
        let bookshelf = allBookshelves.contents?[indexPath.row]
        // remote
        Firebase<BookShelf>.save(item: bookshelf!) { success in
            guard success else { return }
            DispatchQueue.main.async { completion() }
        }
    }
    
}
