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
    let volumeInfo: VolumeInfo?
}

enum Country: String, Codable {
    case us = "US"
}


struct VolumeInfo: Codable {
    let recordIdentifier: String?
    let title: String?
    let authors: [String]?
    var authorString: String {
        get {
            guard (authors != nil) else {
                let newValue = "Anonymous"
                return newValue }
            var newValue: String = ""
            for eachAuthor in authors! {
                newValue += eachAuthor + " "
            }
            return newValue
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
    case recordIdentifier, title, authors, publisher, publishedDate, description, pageCount, averageRating, ratingsCount, previewLink, infoLink, subtitle, smallThumbnail, thumbnail, Language, language
}

struct SearchResults: Codable {
    var items: [BookSearch]?
}
