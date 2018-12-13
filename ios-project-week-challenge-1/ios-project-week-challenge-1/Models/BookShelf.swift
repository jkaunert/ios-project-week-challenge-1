import Foundation

class BookShelf: Codable, FirebaseItem {
    var recordIdentifier: String
    
    let name: String
    let contents: [Book] = []
    let imageLink: String?
}

class Book: Codable, FirebaseItem {
    var recordIdentifier: String
    
    let title: String
    let authors: [String]
    //let publisher: String?
    //let publishedDate: String?
    //let description: String?
    //let pageCount: Int?
    //let averageRating: Double?
    //let ratingsCount: Int?
    //let imageLinks: ImageLinks
    let coverImageLink: String // <- use the cover for the newest book on the shelf?
    //let language: Language?
    //let previewLink: String?
    //let infoLink: String?
    //let subtitle: String?
    let alreadyRead: Bool = false
}


