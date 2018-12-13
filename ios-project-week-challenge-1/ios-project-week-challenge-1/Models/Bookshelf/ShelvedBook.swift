import Foundation


class Book: Codable, FirebaseItem {
    var recordIdentifier: String = "" // Firebase
    
    var title: String?
    var authors: [String]?
    var publisher: String?
    var publishedDate: String?
    var description: String?
    var pageCount: Int?
    var averageRating: Double?
    var ratingsCount: Int?
    var imageLinks: ImageLinks?
    var coverImageLink: String? // compute from imageLinks during init 
    var language: Language?
    var previewLink: String?
    var infoLink: String?
    var subtitle: String?
    var alreadyRead: Bool = false
    var bookshelfTags: [String] = ["allShelvedBooks"] // <- all books added to an array for convenience
    
    init(
     title: String?,
     authors: [String]?,
     publisher: String?,
     publishedDate: String?,
     description: String?,
     pageCount: Int?,
     averageRating: Double?,
     ratingsCount: Int?,
     imageLinks: ImageLinks?,
     language: Language?,
     previewLink: String?,
     infoLink: String?,
     subtitle: String?) {
        
        
    }
}
//var coverImageLink: String
