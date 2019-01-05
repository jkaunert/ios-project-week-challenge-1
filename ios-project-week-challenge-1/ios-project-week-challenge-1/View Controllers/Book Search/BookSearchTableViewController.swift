import Foundation
import UIKit

class BookSearchTableViewController: UITableViewController, UISearchBarDelegate {
    
    
    @IBOutlet weak var searchType: UISegmentedControl!
    
    @IBOutlet weak var searchField: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchField.delegate = self
        self.tableView.reloadData()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchTerm = searchField.text, !searchTerm.isEmpty else { return }
        var resultType: ResultType!
        let segment = searchType.selectedSegmentIndex
        
        switch segment {
        case 0:
            resultType = .title
        case 1:
            resultType = .author
        default:
            resultType = .everything
        }
    
        SearchResultsController.shared.performSearch(with: searchTerm.lowercased(), resultType: resultType) { (searchResults, error) in
            if let error = error {
                NSLog("Error fetching results: \(error)")
                return
            }
            
            SearchResultsController.shared.searchResults = searchResults ?? []
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
            
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let rowCount = SearchResultsController.shared.searchResults.count
        return rowCount
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        guard let cell = tableView.dequeueReusableCell(withIdentifier: BookSearchEntryCell.reuseIdentifier, for: indexPath) as? BookSearchEntryCell else {
//            fatalError("Unable to deque cell")
//        }
        let cell = tableView.dequeueReusableCell(withIdentifier: BookSearchEntryCell.reuseIdentifier, for: indexPath) as! BookSearchEntryCell
        // Configure the cell...
        let result = SearchResultsController.shared.searchResults[indexPath.row]
        
        // load book cover thumbnail image from URL
        cell.bookEntryCoverImage.loadImageFrom(url: URL(string: (result.volumeInfo?.imageLink ?? "https://via.placeholder.com/128x201?text=Cover%20Image%20Unavailable"))!)
        cell.authorNameLabel.text = result.volumeInfo?.authorString
        cell.bookTitleLabel.text = result.volumeInfo?.title
        
        return cell
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let destination = segue.destination as? BookSearchDetailViewController,
            let indexPath = tableView.indexPathForSelectedRow else { return }
        
            let result = SearchResultsController.shared.searchResults[indexPath.row]
            destination.bookDetails = result
        
    }
    
    
    
}
