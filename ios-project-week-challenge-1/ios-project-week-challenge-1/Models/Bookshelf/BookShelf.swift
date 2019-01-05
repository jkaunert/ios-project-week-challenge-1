import Foundation

class BookShelf: Codable, FirebaseItem {
    var recordIdentifier: String = "" // Firebase
    
    var name: String?
    var contents: [Book]? = []
    var bookCount: Int? { return contents?.count }
    var imageLink: String? = "https://via.placeholder.com/128x201?text=Go%20ahead%20and%20add%20your%20first%20Book!" // image will be set as the cover image of the most
                                                                                                                     // recent book added, otherwise this groovy
                                                                                                                     // placeholder will be used.
    
    init(name: String) {
        self.name = name
        
    }
    
    
}

class AllBookShelves: Codable, FirebaseItem {
    var recordIdentifier: String = "" // Firebase
    var name: String? = "All Bookshelves"
    var contents: [BookShelf]? = [BookShelf(name: "Favorites")]
    var bookshelfCount: Int? { return contents?.count }
    
    func addBookshelf(bookshelf: BookShelf) {
        contents?.append(bookshelf)
    }
}


