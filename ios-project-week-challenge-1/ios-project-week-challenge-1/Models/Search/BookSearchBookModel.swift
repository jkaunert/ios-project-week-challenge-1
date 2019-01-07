import Foundation
import UIKit

struct BookSearch: Codable {
    let kind: String?
    let totalItems: Int?
    let items: [Item]?
}

struct Item: Codable {
    let id, etag: String?
    let selfLink: String?
    var volumeInfo: VolumeInfo?
}

enum Country: String, Codable {
    case us = "US"
}


struct VolumeInfo: Codable {
    lazy var recordIdentifier: String = ""
    lazy var userReview: String = "Add Your Review Here..."
    lazy var hasRead: Bool = false
    let title: String?
    let authors: [String]?
    var authorString: String {
        get {
            guard (authors != nil) else { return "Anonymous" }
            //let newValue = authors?.joined(separator: ", ")
            return (authors?.joined(separator: ", "))!
        }
    }
    let publisher: String?
    let publishedDate: String?
    let description: String?
    let pageCount: Int?
    let averageRating: Double?
    let ratingsCount: Int?
    let imageLinks: ImageLinks?
    //let language: Language?
    let previewLink: String?
    let infoLink: String?
    let subtitle: String?
    var imageLink: String? {
        
        get {
            return self.imageLinks?.smallThumbnail 
        }
    }
}

struct ImageLinks: Codable {
    let smallThumbnail, thumbnail: String?
}


enum TypeEnum: String, Codable {
    case isbn10 = "ISBN_10"
    case isbn13 = "ISBN_13"
    case other = "OTHER"
}

enum Language: String, Codable {
    case en = "en"
    case es = "es"
}


enum CodingKeys: String, CodingKey {
    case title, authors, publisher, publishedDate, description, pageCount, averageRating, ratingsCount, previewLink, infoLink, subtitle, smallThumbnail, thumbnail, Language, language, recordIdentifier
}

struct SearchResults: Codable {
    var items: [BookSearch]?
}
