import Foundation


class Book: Codable, FirebaseItem {
    var recordIdentifier: String = "" // Firebase
    
    var title: String?
    var authors: [String]? // mutate to String during init
    //var authorString: String = ""
    var publisher: String?
    var publishedDate: String?
    var description: String?
    var pageCount: Int?
    var averageRating: Double?
    var ratingsCount: Int?
    var imageLinks: ImageLinks?
    var coverImageLink: String? // compute String from imageLinks at init
    var language: Language? // compute String from language at init
    var previewLink: String?
    var infoLink: String?
    var subtitle: String?
    var alreadyRead: Bool = false
    var bookshelfTags: [String] = ["allShelvedBooks"] // <- all books added to allShelvedBooks array for convenience
    var authorString: String?
    var imageLink: String?
//    var authorString: String {
//        get {
//            guard (authors != nil) || (!(authors?.isEmpty)!) else { return "Anonymous"}
//            var newValue: String = ""
//            for eachAuthor in authors! {
//                newValue += eachAuthor + " "
//            }
//            return newValue
//        }
//    }

    init(
     title: String?,
     authors: [String]?,
     authorString: String?,
     publisher: String?,
     publishedDate: String?,
     description: String?,
     pageCount: Int?,
     averageRating: Double?,
     ratingsCount: Int?,
     imageLinks: ImageLinks?,
     imageLink: String?,
     language: Language?,
     previewLink: String?,
     infoLink: String?,
     subtitle: String?) {
        
        self.title = title
        self.authors = authors //  FIXME: make computed - mutate to string
        self.publisher = publisher
        self.publishedDate = publishedDate
        self.description = description
        self.pageCount = pageCount
        self.averageRating = averageRating
        self.ratingsCount = ratingsCount
        self.imageLinks = imageLinks
        self.language = language
        self.previewLink = previewLink
        self.infoLink = infoLink
        self.subtitle = subtitle
        self.authors = authors
        self.authorString = authorString
        self.imageLink = imageLink
    }
}

