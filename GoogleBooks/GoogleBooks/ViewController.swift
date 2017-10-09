//
//  ViewController.swift
//  GoogleBooks
//
//  Created by INO1 on 09.10.17.
//  Copyright © 2017 1encore. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    var books = [Book]()
    	
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchBar.delegate = self
        tableView.delegate = self
        tableView.dataSource = self
        
    }
    
    func getBooks(query: String){
        let query = query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        let url = "https://www.googleapis.com/books/v1/volumes?q=\(query)"
        
        URLSession.shared.dataTask(with: URL(string: url)!) { (data, response, error) in
            if(error != nil){
                print(error?.localizedDescription)
            }else{
                let json = try! JSONSerialization.jsonObject(with: data!, options: .allowFragments) as! [String: AnyObject]
                
                if let items = json["items"] as? [[String: AnyObject]] {
                    print("got items", items)
                    
                    self.books = []
                    for item in items{
                        if let volumeInfo = item["volumeInfo"] as? [String: AnyObject] {
                            let book = Book()
                            book.title = volumeInfo["title"] as? String
                            
                            if let temp = volumeInfo["authors"] as? [String]{
                                var aut = " "
                                for i in 0..<temp.count{
                                    aut = aut + temp[i]
                                }
                                book.author = aut
                            }
                            
                            if let imageLinks = volumeInfo["imageLinks"] as? [String: String] {
                                book.imageUrl = imageLinks["thumbnail"]
                            }
                            self.books.append(book)
                        }
                    }
                    print(self.books)
                    
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                }
            }
        }.resume()
        
        print(url)
    }
}

extension ViewController : UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.books.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! BookItemTableViewCell
        
        cell.titleLabel.text = books[indexPath.row].title!
        cell.authorLabel.text = books[indexPath.row].author!
        
        return cell
    }
}

extension ViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        let text = searchBar.text
        print(text)
        self.getBooks(query: text!)
    }
}
