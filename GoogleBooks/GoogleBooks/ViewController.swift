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
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func downloadBooks(bookTitle: String){
        let path = "https://www.googleapis.com/books/v1/volumes?q=\(bookTitle)"
        let url = URL(string: path)
        let session = URLSession.shared.dataTask(with: url)
        
        let task = session.dataTast(with:url!) {(data, response, error) in }
        
        task.resume()
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BookCell", for: indexPath)
        
        //configure cell
        
        
        return cell;
    }
}
