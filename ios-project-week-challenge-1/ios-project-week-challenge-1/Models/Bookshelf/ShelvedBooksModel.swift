import Foundation

class ShelvedBooksModel {
    static let shared = ShelvedBooksModel()
    private init(){}
    var delegate: ModelUpdateClient?
    
    var allShelvedBooks = AllShelvedBooks()
    
    
     //MARK: book methods
    
        func countAllBooks() -> Int {
            return allShelvedBooks.contents.count
        }
    
        func book(forIndex index: Int) -> Book {
            return allShelvedBooks.contents[index]
        }
    
        func bookAt(at indexPath: IndexPath) -> Book {
            return allShelvedBooks.contents[indexPath.row]
        }
    
        // MARK: Book Core Database Management Methods
    func createShelvableBook(from searchItem: Item) -> Book {
        return Book(recordIdentifier: searchItem.volumeInfo?.recordIdentifier ?? "", title: searchItem.volumeInfo?.title, authors: searchItem.volumeInfo?.authors, authorString: searchItem.volumeInfo?.authorString, publisher: searchItem.volumeInfo?.publisher, publishedDate: searchItem.volumeInfo?.publishedDate, description: searchItem.volumeInfo?.description, pageCount: searchItem.volumeInfo?.pageCount, averageRating: searchItem.volumeInfo?.averageRating, ratingsCount: searchItem.volumeInfo?.ratingsCount, imageLinks: searchItem.volumeInfo?.imageLinks, imageLink: searchItem.volumeInfo?.imageLink, previewLink: searchItem.volumeInfo?.previewLink, infoLink: searchItem.volumeInfo?.infoLink, subtitle: searchItem.volumeInfo?.subtitle)
    }
        //FIXME:
    func addNewBook(book: Item, to bookshelfName: String, completion: @escaping () -> Void) {
            // FIXME: logic for determining bookshelf that book is in
            let book = book
            let shelvableBook = createShelvableBook(from: book)
            //let bookshelf = BookshelfModel.shared.allBookshelves.contents
            let bookshelfName = bookshelfName
        for shelf in BookshelfModel.shared.allBookshelves.contents!{
                if shelf.name == "Favorites" {
                    shelf.contents?.append(shelvableBook)
                }else {
                   var newShelf = BookShelf(name: "Favorites")
                   newShelf.contents?.append(shelvableBook)
                   BookshelfModel.shared.allBookshelves.addBookshelf(bookshelf: newShelf)
                }
            }
        
            // remote
            Firebase<Book>.save(item: shelvableBook) { success in
                guard success else { return }
            Firebase<AllBookShelves>.save(item: BookshelfModel.shared.allBookshelves) { success in
                guard success else { return }
                DispatchQueue.main.async { completion() }
            }
    
        }
        func deleteBook(at indexPath: IndexPath, completion: @escaping () -> Void) {
            // FIXME: logic for determining bookshelf that book is in
            // local
            let bookshelf = BookshelfModel.shared.allBookshelves.contents?[indexPath.row]
            BookshelfModel.shared.allBookshelves.contents?.remove(at: indexPath.row)
            // remote
            Firebase<BookShelf>.delete(item: bookshelf!) { success in
                guard success else { return }
                DispatchQueue.main.async { completion() }
            }
        }
        func updateBook(at indexPath: IndexPath, completion: @escaping () -> Void) {
            // FIXME: logic for determining bookshelf that book is in
            // local
            let bookshelf = BookshelfModel.shared.allBookshelves.contents?[indexPath.row]
            // remote
            Firebase<BookShelf>.save(item: bookshelf!) { success in
                guard success else { return }
                DispatchQueue.main.async { completion() }
            }
        }
}
}
