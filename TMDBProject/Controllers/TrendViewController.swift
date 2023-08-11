//
//  ViewController.swift
//  TMDBProject
//
//  Created by 한성봉 on 2023/08/11.
//

import UIKit

class TrendViewController: UIViewController {

    @IBOutlet var trendTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        delegateTableView()
        configureTableView()
    }
}


extension TrendViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = trendTableView.dequeueReusableCell(withIdentifier: TrendTableViewCell.identifier) as? TrendTableViewCell else {
            return UITableViewCell()
        }
        
        cell.configureCell()
        return cell
    }
}

extension TrendViewController {
    func delegateTableView() {
        trendTableView.delegate = self
        trendTableView.dataSource = self
    }
    
    func configureTableView() {
        trendTableView.rowHeight = UITableView.automaticDimension
    }
}


