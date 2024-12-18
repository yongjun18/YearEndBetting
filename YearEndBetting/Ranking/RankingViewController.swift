//
//  RankingViewController.swift
//  YearEndBetting
//
//  Created by yongjun18 on 12/2/24.
//

import Foundation
import UIKit
import PinLayout

class RankingViewController: UIViewController {
    
    // MARK: - Properties
    
    private var upperArea = UIView()
    private var rankDescLabel = UILabel()
    private var currentRankLabel = UILabel()
    private var groupNameLabel = UILabel()
    
    private var leftLaurelView = UIImageView()
    private var rightLaurelView = UIImageView()
    
    private var lowerArea = UIView()
    private var listTitleLabel = UILabel()
    private var groupListTableView = UITableView()
    
    // MARK: - Life Cycle
    
    init() {
        super.init(nibName: nil, bundle: nil)
        
        groupListTableView.estimatedRowHeight = RankingGroupCell.cellHeight
        groupListTableView.delegate = self
        groupListTableView.dataSource = self
        groupListTableView.register(RankingGroupCell.self, forCellReuseIdentifier: RankingGroupCell.reuseIdentifier)
        groupListTableView.separatorStyle = .none
        groupListTableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 6.0, right: 0)
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        
        self.view.addSubview(upperArea)
        
        rankDescLabel.text = "현재 코인 순위"
        rankDescLabel.textColor = .darkGray
        rankDescLabel.sizeToFit()
        upperArea.addSubview(rankDescLabel)
        
        currentRankLabel.text = "1위"
        currentRankLabel.font = .systemFont(ofSize: 30, weight: .heavy)
        currentRankLabel.sizeToFit()
        upperArea.addSubview(currentRankLabel)
        
        groupNameLabel.text = "애교가 넘치는 사랑의 하츄핑"
        groupNameLabel.font = .systemFont(ofSize: 15, weight: .semibold)
        groupNameLabel.textColor = .systemGray
        groupNameLabel.sizeToFit()
        upperArea.addSubview(groupNameLabel)
        
        leftLaurelView.contentMode = .scaleAspectFit
        leftLaurelView.tintColor = .systemGray3
        leftLaurelView.image = UIImage(systemName: "laurel.leading")
        upperArea.addSubview(leftLaurelView)
        
        rightLaurelView.contentMode = .scaleAspectFit
        rightLaurelView.tintColor = .systemGray3
        rightLaurelView.image = UIImage(systemName: "laurel.trailing")
        upperArea.addSubview(rightLaurelView)
        
        self.view.addSubview(lowerArea)
        
        listTitleLabel.text = "전체 순위"
        listTitleLabel.font = .systemFont(ofSize: 16)
        lowerArea.addSubview(listTitleLabel)
        
        lowerArea.addSubview(groupListTableView)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        upperArea.pin.top(self.view.pin.safeArea)
            .horizontally(self.view.pin.safeArea).height(200)
        rankDescLabel.pin.top(70).hCenter()
        currentRankLabel.pin.bottom(70).hCenter()
        groupNameLabel.pin.bottom(30).hCenter()
        leftLaurelView.pin.before(of: currentRankLabel).vCenter(to: currentRankLabel.edge.vCenter)
            .size(30).marginRight(5)
        rightLaurelView.pin.after(of: currentRankLabel).vCenter(to: currentRankLabel.edge.vCenter)
            .size(30).marginLeft(5)
        
        lowerArea.pin.below(of: upperArea).horizontally(self.view.pin.safeArea).bottom()
        listTitleLabel.pin.top(30).horizontally().marginHorizontal(RankingGroupCell.cellMarginHorizontal).sizeToFit(.width)
        groupListTableView.pin.below(of: listTitleLabel).horizontally().bottom().marginTop(15)
    }
    
}

// MARK: - TableView DataSource

extension RankingViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: RankingGroupCell.reuseIdentifier, for: indexPath) as? RankingGroupCell else {
            return UITableViewCell()
        }
        return cell
    }
}

// MARK: - TableView Delegate

extension RankingViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return RankingGroupCell.cellHeight
    }
}

