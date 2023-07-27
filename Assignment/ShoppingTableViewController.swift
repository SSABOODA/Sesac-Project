//
//  ShoppingTableViewController.swift
//  SeSAC3Week3
//
//  Created by 한성봉 on 2023/07/27.
//

import UIKit

class ShoppingTableViewController: UITableViewController {

    @IBOutlet var mainView: UIView!
    @IBOutlet var textField: UITextField!
    @IBOutlet var addButton: UIButton!
    
    var shoppingList = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = 50
        
        designView()
        designButton()
        
        
    }
    
    @IBAction func addButtonClicked(_ sender: UIButton) {
        let text = textField.text!
        shoppingList.append(text)
        tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return shoppingList.count
    }
    
    // checkmark.square
    // checkmark.square.fill
    // star
    // star.fill
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "shoppingCell")!
        
        
        let imgView = UIImageView(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
        imgView.image = UIImage(systemName: "start")
        
        cell.textLabel?.text = shoppingList[indexPath.row]
        cell.imageView?.image = UIImage(systemName: "heart")
        cell.accessoryView = imgView
        return cell
    }
    
    func designView() {
        mainView.layer.cornerRadius = 10
        mainView.clipsToBounds = true
    }
    
    func designButton() {
        addButton.layer.cornerRadius = 5
        addButton.clipsToBounds = true
        addButton.backgroundColor = .systemGray5
    }

    
    
    
    
    
}
