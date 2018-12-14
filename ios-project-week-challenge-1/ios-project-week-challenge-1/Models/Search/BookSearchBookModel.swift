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
    let title: String?
    let authors: [String]?
    var authorString: String {
        get {
            guard (authors != nil) || (!(authors?.isEmpty)!) else { return "Anonymous"}
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
    let language: Language?
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
}


private enum CodingKeys: String, CodingKey {
    case title, authors, publisher, publishedDate, description, pageCount, averageRating, ratingsCount, previewLink, infoLink, subtitle
}

struct SearchResults: Codable {
    var items: [BookSearch]
}
