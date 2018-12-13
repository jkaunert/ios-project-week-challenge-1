import Foundation


class BookshelfModel {
    static let shared = BookshelfModel()
    private init() {}
    var delegate: ModelUpdateClient?
    
    var allBooks: [Book] = []
    var allBookshelves: [BookShelf] = []
    
    // MARK: bookshelf methods
    func countAllBookshelves() -> Int {
        return allBookshelves.count
    }
    
    func bookshelf(forIndex index: Int) -> BookShelf {
        return allBookshelves[index]
    }
    
    func bookshelfAt(at indexPath: IndexPath) -> BookShelf {
        return allBookshelves[indexPath.row]
    }
    
    // MARK: Bookshelf Core Database Management Methods
    
    func addNewBookshelf(bookshelf: BookShelf, completion: @escaping () -> Void) {
        //        // FIXME:
        let bookshelf = bookshelf
        //append to robots array, updating our local model
        allBookshelves.append(bookshelf)
        // save it sending to firebase
        Firebase<BookShelf>.save(item: bookshelf) { success in
            guard success else { return }
            DispatchQueue.main.async { completion() }
        }
        
    }
    func deleteBookshelf(at indexPath: IndexPath, completion: @escaping () -> Void) {
        // FIXME:
        //local
        let bookshelf = allBookshelves[indexPath.row]
        allBookshelves.remove(at: indexPath.row)
        //remote
        Firebase<BookShelf>.delete(item: bookshelf) { success in
            guard success else { return }
            DispatchQueue.main.async { completion() }
        }
    }
    func updateBookshelf(at indexPath: IndexPath, completion: @escaping () -> Void) {
        // FIXME:
        //local
        let bookshelf = allBookshelves[indexPath.row]
        //remote
        Firebase<BookShelf>.save(item: bookshelf) { success in
            guard success else { return }
            DispatchQueue.main.async { completion() }
        }
    }
    
    // MARK: book methods
    func countAllBooks() -> Int {
        return allBooks.count
    }
    
    func book(forIndex index: Int) -> Book {
        return allBooks[index]
    }
    
    func bookAt(at indexPath: IndexPath) -> Book {
        return allBooks[indexPath.row]
    }
    
    // MARK: Book Core Database Management Methods
    
    func addNewBook(bookshelf: BookShelf, completion: @escaping () -> Void) {
        //        // FIXME: logic for determining bookshelf that book is in
        let bookshelf = bookshelf
        //append to robots array, updating our local model
        allBookshelves.append(bookshelf)
        // save it sending to firebase
        Firebase<BookShelf>.save(item: bookshelf) { success in
            guard success else { return }
            DispatchQueue.main.async { completion() }
        }
        
    }
    func deleteBook(at indexPath: IndexPath, completion: @escaping () -> Void) {
        // FIXME: logic for determining bookshelf that book is in
        //local
        let bookshelf = allBookshelves[indexPath.row]
        allBookshelves.remove(at: indexPath.row)
        //remote
        Firebase<BookShelf>.delete(item: bookshelf) { success in
            guard success else { return }
            DispatchQueue.main.async { completion() }
        }
    }
    func updateBook(at indexPath: IndexPath, completion: @escaping () -> Void) {
        // FIXME: logic for determining bookshelf that book is in
        //local
        let bookshelf = allBookshelves[indexPath.row]
        //remote
        Firebase<BookShelf>.save(item: bookshelf) { success in
            guard success else { return }
            DispatchQueue.main.async { completion() }
        }
    }
    
}
