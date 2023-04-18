//
//  ViewController.swift
//  API Calling (31-01-2023)
//
//  Created by undhad kaushik on 01/02/23.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var userTabelView: UITableView!
    var aarrUsers: [Dictionary<String, AnyObject>] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
        
    }
    
    private func setup(){
        getUsers()
    }
    
    private func getUsers(){
        guard let url = URL( string: "https://gorest.co.in/public/v2/users") else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.httpBody = nil
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let apiData = data else { return }
            do{
                let json = try JSONSerialization.jsonObject(with: apiData) as! [Dictionary<String, AnyObject>]
                self.aarrUsers = json
                DispatchQueue.main.async{
                    self.userTabelView.reloadData()
                }
            } catch {
                print(error.localizedDescription)
            }
        }
        .resume()
    }
}

extension ViewController: UITableViewDelegate ,UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return aarrUsers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = UITableViewCell()
        let rowDictionary = aarrUsers[indexPath.row]
        cell.textLabel?.numberOfLines = 0
         cell.textLabel?.text = rowDictionary["name"] as! String
        cell.textLabel?.text = "\(rowDictionary["name"] as! String)\n\(rowDictionary["email"] as! String)"
        return cell
    }
}

