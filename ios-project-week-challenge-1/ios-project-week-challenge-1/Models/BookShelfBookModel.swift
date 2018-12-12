import Foundation

struct BookShelf {
    let name: String
    let contents: [Book] = []
    let imageLink: String?
}

struct Book {
    let title: String
    let authors: [String]?
    //let publisher: String?
    //let publishedDate: String?
    //let description: String?
    //let pageCount: Int?
    //let averageRating: Double?
    //let ratingsCount: Int?
    //let imageLinks: ImageLinks
    let coverImageLink: String
    //let language: Language?
    //let previewLink: String?
    //let infoLink: String?
    //let subtitle: String?
    let alreadyRead: Bool = false
}


