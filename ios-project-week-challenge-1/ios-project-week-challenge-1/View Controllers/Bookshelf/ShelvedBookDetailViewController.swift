import Foundation
import UIKit


class ShelvedBookDetailViewController: UIViewController, UITextViewDelegate {
    
    var bookshelfDetails: [Item]?
    var bookDetails: Item?
    var indexForBook: Int?
    var bookShelfTitleString: String?
    //var didRead: Bool?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        detailBookCoverImageView.loadImageFrom(url: URL(string: (bookDetails?.volumeInfo?.imageLink ?? "https://via.placeholder.com/128x201?text=Cover%20Image%20Unavailable"))!)
        detailBookTitleLabel.text = bookDetails?.volumeInfo?.title
        detailBookAuthorNameLabel.text = bookDetails?.volumeInfo?.authorString ?? "unknown"
        didReadSwitch.isOn = (SearchResultsController.shared.allBookshelves[bookShelfTitleString!]?[indexForBook!].volumeInfo?.hasRead)!
        userReviewTextView.text = bookDetails?.volumeInfo?.userReview
    }
    
    override func viewDidLoad() {
        super .viewDidLoad()
        userReviewTextView.delegate = self
        
    }
    
    
    @IBOutlet weak var detailBookCoverImageView: UIImageView!
    
    @IBOutlet weak var detailBookTitleLabel: UILabel!
    @IBOutlet weak var detailBookAuthorNameLabel: UILabel!
    
    
    @IBOutlet weak var didReadStatusLabel: UILabel!
    @IBOutlet weak var didReadSwitch: UISwitch!
    @IBAction func didReadStatusSwitch(_ sender: Any) {
        if didReadSwitch.isOn == true {
            didReadSwitch.isOn = false
            let shelf = bookShelfTitleString!
            if var tempRef = SearchResultsController.shared.allBookshelves[shelf] {
                tempRef[indexForBook!].volumeInfo?.hasRead = false
                //print("turning off! \(tempRef[indexForBook!].volumeInfo?.hasRead)")
                SearchResultsController.shared.allBookshelves[shelf] = tempRef
            }
        } else {
            didReadSwitch.isOn = true
            let shelf = bookShelfTitleString!
            if var tempRef = SearchResultsController.shared.allBookshelves[shelf] {
                tempRef[indexForBook!].volumeInfo?.hasRead = true
                //print("turning on! \(tempRef[indexForBook!].volumeInfo?.hasRead)")
                SearchResultsController.shared.allBookshelves[shelf] = tempRef
            }
        }
    }
    
    @IBAction func removeFromShelf(_ sender: Any) {
        let shelf = bookShelfTitleString!
        if var tempRef = SearchResultsController.shared.allBookshelves[shelf] {
            tempRef.remove(at: indexForBook!)
            //print(tempRef)
            SearchResultsController.shared.allBookshelves[shelf] = tempRef
            navigationController?.popViewController(animated: true)
            
            
        }
    }
    
//    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
//        textField.resignFirstResponder()
//        let shelf = bookShelfTitleString!
//        if var tempRef = SearchResultsController.shared.allBookshelves[shelf] {
//            //tempRef.remove(at: indexForBook!)
//            print(tempRef)
//            tempRef[indexForBook!].volumeInfo?.userReview = userReviewTextView.text
//
//            SearchResultsController.shared.allBookshelves[shelf] = tempRef
//            //navigationController?.popViewController(animated: true)
//
//
//        }
//        return true
//    }
    func textViewDidBeginEditing(_ textView: UITextView) {
        print("print1")
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        print("print2")
    }
    
    func textViewDidChange(_ textView: UITextView) {
                let shelf = bookShelfTitleString!
                if var tempRef = SearchResultsController.shared.allBookshelves[shelf] {
                    //tempRef.remove(at: indexForBook!)
                    print(tempRef)
                    tempRef[indexForBook!].volumeInfo?.userReview = userReviewTextView.text
                    print(tempRef[indexForBook!].volumeInfo?.userReview)
        
                    SearchResultsController.shared.allBookshelves[shelf] = tempRef
                    //navigationController?.popViewController(animated: true)
        
        
                }
    }
    
    @IBOutlet weak var writeAReviewLabel: UILabel!
    @IBOutlet weak var userReviewTextView: UITextView!
    
}

