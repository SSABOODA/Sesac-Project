//
//  DetailViewController.swift
//  TMDBProject
//
//  Created by 한성봉 on 2023/08/12.
//

import UIKit
import Network

class DetailViewController: UIViewController {
    
    @IBOutlet var detailTableView: UITableView!
    @IBOutlet var overviewBackView: UIView!
    @IBOutlet var headerImageView: UIImageView!
    @IBOutlet var overviewLabel: UILabel!
    @IBOutlet var expandButton: UIButton!
    
    var movie: Movie?
    var castInfo: CastInfo?
    
    var isExpand: Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()
        
        callRequest()
        delegateTableView()
        configureTableView()
        
        configureNavigationBar()
        configureHeaderView()
        designHeaderView()
    }
    
    @IBAction func expandButtonClicked(_ sender: UIButton) {
        expandButton.isHidden.toggle()
        overviewLabel.numberOfLines = expandButton.isHidden ? 0 : 2
    }
    
    func callRequest() {
        guard let movie else { return }
        TMDBAPIManager.shared.callRequest(
            of: CastInfo.self,
            type: EndPoint.credit,
            movieId: movie.id,
            seriesId: nil,
            seasonId: nil,
            query: nil
        ) { response in
            self.castInfo = response
            self.detailTableView.reloadData()
        }
    }
    
    private func configureNavigationBar() {
        title = "출연/제작"
        self.navigationController?.navigationBar.tintColor = .white
        self.navigationController?.navigationBar.topItem?.title = ""
    }
    
    private func configureHeaderView() {
        headerImageView.contentMode = .scaleAspectFill
        overviewLabel.numberOfLines = 2
        overviewBackView.layer.addBorder([.top, .bottom], color: UIColor.systemGray5, width: 1)
    }
    
    private func designHeaderView() {
        guard let movie else { return }
        if let imageURL = URL(string: movie.fullImageURL) {
            [
                headerImageView,
            ].forEach { image in
                image.kf.indicatorType = .activity
                image.kf.setImage(with: imageURL)
            }
            
        }
        overviewLabel.text = movie.description
    }
}

extension DetailViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let castCount = castInfo?.castList.count else { return 0 }
        return castCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = detailTableView.dequeueReusableCell(withIdentifier: DetailTableViewCell.identifier) as? DetailTableViewCell else {
            return UITableViewCell()
        }
        if let castList = castInfo?.castList {
            cell.configureCell(castList[indexPath.row])
        }
       
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Cast"
    }
}


extension DetailViewController {
    func delegateTableView() {
        detailTableView.delegate = self
        detailTableView.dataSource = self
    }
    
    func configureTableView() {
        detailTableView.rowHeight = 130
    }
}
