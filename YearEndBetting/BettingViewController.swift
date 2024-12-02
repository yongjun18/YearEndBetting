//
//  BettingViewController.swift
//  YearEndBetting
//
//  Created by yongjun18 on 12/1/24.
//

import Foundation
import UIKit
import PinLayout

class BettingViewController: UIViewController {
    
    // MARK: - Properties
    
    private var currentCoinLabel = UILabel()
    private var askingSelectionLabel = UILabel()
    private var groupListTableView = UITableView()
    private var selectedTargetLabel = UILabel()
    private var amountPlaceHolder = UILabel()
    private var amountKeyboardView = AmountKeyboardView()
    
    private enum AskingStatus {
        case askingTarget
        case askingAmount
    }
    private var askingStatus: AskingStatus? {
        didSet {
            switch askingStatus {
            case .askingTarget:
                askingSelectionLabel.isHidden = false
                groupListTableView.isHidden = false
                selectedTargetLabel.isHidden = true
                amountPlaceHolder.isHidden = true
                amountKeyboardView.isHidden = true
            case .askingAmount:
                askingSelectionLabel.isHidden = true
                groupListTableView.isHidden = true
                selectedTargetLabel.isHidden = false
                amountPlaceHolder.isHidden = false
                amountKeyboardView.isHidden = false
            default:
                break
            }
        }
    }
    
    // MARK: - Life Cycle
    
    init() {
        super.init(nibName: nil, bundle: nil)
        
        groupListTableView.estimatedRowHeight = GroupItemCell.cellHeight
        groupListTableView.delegate = self
        groupListTableView.dataSource = self
        groupListTableView.register(GroupItemCell.self, forCellReuseIdentifier: GroupItemCell.reuseIdentifier)
        groupListTableView.separatorStyle = .none
        groupListTableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 6.0, right: 0)
        
        amountKeyboardView.delegate = self
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        askingStatus = .askingTarget
        
        currentCoinLabel.font = .systemFont(ofSize: 20, weight: .semibold)
        currentCoinLabel.numberOfLines = 0
        currentCoinLabel.text = "현재 1,000,000 AMC 보유 중!"
        self.view.addSubview(currentCoinLabel)
        
        askingSelectionLabel.text = "누구에게 베팅할까요?"
        askingSelectionLabel.font = .systemFont(ofSize: 20, weight: .semibold)
        askingSelectionLabel.numberOfLines = 0
        self.view.addSubview(askingSelectionLabel)
        
        self.view.addSubview(groupListTableView)
        
        selectedTargetLabel.font = .systemFont(ofSize: 22, weight: .semibold)
        selectedTargetLabel.numberOfLines = 0
        let target = "애교가 넘치는 사랑의 하츄핑"
        let selectedTargetString = "\(target)에게"
        let targetAttrString = NSMutableAttributedString(string: selectedTargetString)
        let targetRange = (selectedTargetString as NSString).range(of: target)
        targetAttrString.addAttribute(.foregroundColor, value: UIColor(named: "DarkPink") as Any, range: targetRange)
        selectedTargetLabel.attributedText = targetAttrString
        self.view.addSubview(selectedTargetLabel)
        
        amountPlaceHolder.text = "얼마나 베팅할까요?"
        amountPlaceHolder.font = .systemFont(ofSize: 25, weight: .semibold)
        amountPlaceHolder.numberOfLines = 0
        amountPlaceHolder.textColor = .systemGray
        self.view.addSubview(amountPlaceHolder)
        
        self.view.addSubview(amountKeyboardView)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        layout()
    }
    
}

// MARK: - TableView DataSource

extension BettingViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: GroupItemCell.reuseIdentifier, for: indexPath) as? GroupItemCell else {
            return UITableViewCell()
        }
        cell.delegate = self
        cell.cellIndex = indexPath.row
        return cell
    }
}

// MARK: - TableView Delegate

extension BettingViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return GroupItemCell.cellHeight
    }
}

// MARK: - GroupItemCellDelegate

extension BettingViewController: GroupItemCellDelegate {
    func cellContentsTouched(cellIndex: Int) {
        askingStatus = .askingAmount
        layout()
    }
}

// MARK: - AnimalKeyboardViewDelegate

extension BettingViewController: AmountKeyboardViewDelegate {
    func digitStringTouched(string: String) {
        
    }
    
    func eraseDigitTouched() {
        
    }
}

// MARK: - Private Extensions

private extension BettingViewController {
    func layout() {
        currentCoinLabel.pin.top(self.view.pin.safeArea).horizontally(self.view.pin.safeArea)
            .marginTop(60).marginHorizontal(20).sizeToFit(.width)
        
        if askingStatus == .askingTarget {
            askingSelectionLabel.pin.below(of: currentCoinLabel).horizontally(self.view.pin.safeArea)
                .marginTop(15).marginHorizontal(20).sizeToFit(.width)
            groupListTableView.pin.below(of: askingSelectionLabel).horizontally(self.view.pin.safeArea).bottom()
                .marginTop(110)
        }
        if askingStatus == .askingAmount {
            selectedTargetLabel.pin.below(of: currentCoinLabel).horizontally(self.view.pin.safeArea)
                .marginTop(15).marginHorizontal(20).sizeToFit(.width)
            amountPlaceHolder.pin.below(of: selectedTargetLabel).horizontally(self.view.pin.safeArea)
                .marginTop(45).marginHorizontal(20).sizeToFit(.width)
            amountKeyboardView.pin.bottom(self.view.pin.safeArea).horizontally(self.view.pin.safeArea)
                .height(250).marginHorizontal(20).marginBottom(10)
        }
    }
}

