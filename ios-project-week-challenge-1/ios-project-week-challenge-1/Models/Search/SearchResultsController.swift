import Foundation
import UIKit

class SearchResultsController {
    
    static let shared = SearchResultsController()
    private init(){}
    
    let endpoint = "https://www.googleapis.com/books/v1/volumes?"
    let key = "AIzaSyCWBbRuIyE8lAmu-s-U1mJLKkDi_fldYDQ"
    let testURL: URL! = URL(string: "https://www.googleapis.com/books/v1/volumes?q=Star%20wars&intitle:=Star%20wars&maxResults=40&key=AIzaSyCWBbRuIyE8lAmu-s-U1mJLKkDi_fldYDQ")
    var searchResults: [Item] = []
    var allBookshelves: [String : [Item]] = ["Favorites" : [], "Read" : []]
    
    func addBookshelf(name: String = "you forgot to name the shelf stoopid."){
        allBookshelves[name] = []
        
    }
    func removeBookshelf(name: String){
        allBookshelves[name] = nil
        
    }
    func performSearch(with searchTerm: String, resultType: ResultType, completion: @escaping ([Item]?, Error?) -> Void) {
        self.searchResults = []
        // base URL for search
        guard let baseURL = URL(string: endpoint) else {
            fatalError("Unable to create baseURL")
        }
        
        // break baseURL into components
        guard var urlComponents = URLComponents(url: baseURL, resolvingAgainstBaseURL: true) else {
            fatalError("Unable to resolve baseURL components")
        }
        
        // create the query item by ...
        if resultType == .title {
            // title...
            let searchQueryTerm = URLQueryItem(name: "q", value: searchTerm)
            let searchQueryType = URLQueryItem(name: "intitle:", value: searchTerm)
            let maxResults = URLQueryItem(name: "maxResults", value: "40")
            let apiKey = URLQueryItem(name: "key", value: key)
            urlComponents.queryItems = [searchQueryTerm, searchQueryType, maxResults, apiKey]
            //return
        } else if resultType == .author {
            let searchQueryTerm = URLQueryItem(name: "q", value: searchTerm)
            let searchQueryType = URLQueryItem(name: "inauthor:", value: searchTerm)
            let maxResults = URLQueryItem(name: "maxResults", value: "40")
            let apiKey = URLQueryItem(name: "key", value: key)
            urlComponents.queryItems = [searchQueryTerm, searchQueryType, maxResults, apiKey]
        } else {
            let searchQueryTerm = URLQueryItem(name: "q", value: searchTerm)
            let maxResults = URLQueryItem(name: "maxResults", value: "40")
            //let searchQueryType = URLQueryItem(name: "+inauthor:", value: searchTerm)
            let apiKey = URLQueryItem(name: "key", value: key)
            urlComponents.queryItems = [searchQueryTerm, maxResults, apiKey]
        }

        
        //re-compose required components back into a conforming URL
        // a fully qualified search term shoul look like this -->
        ///https://www.googleapis.com/books/v1/volumes?q=inauthor:Carlos+Castaneda&key=AIzaSyCWBbRuIyE8lAmu-s-U1mJLKkDi_fldYDQ
        
        guard let searchURL = urlComponents.url else {
            NSLog("Error constructing a valid conforming URL for \(searchTerm)")
            completion(nil, NSError())
            return
        }
        print(searchURL)
        //create GET request
        var request = URLRequest(url: searchURL)
        request.httpMethod = "GET"
        
        //create dataTask
        let dataTask = URLSession.shared.dataTask(with: request) {
            
            data, _, error in
            
            //unwrap the data
            guard error == nil, let data = data else {
                if let error = error {
                    NSLog("Error unwarapping data: \(error)")
                    completion(nil, error)
                    return
                }
                NSLog("Unable to fetch data")
                completion(nil, error)
                return
            }
            print("no error and have data")
            
            // convert the data
            do{
                //create the decoder instance
                let decoder = JSONDecoder()
                
                
                //decode data into array of results
            
                let results = try decoder.decode(BookSearch.self, from: data)
                self.searchResults = results.items!
                print(self.searchResults)
                
                
                // return to completion handler
                completion(self.searchResults, nil)
                
            } catch {
                NSLog("Unable to decode data: \(error)")
                completion(nil, error)
            }
        }
        dataTask.resume()
        
    }
}
