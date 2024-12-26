//
//  WelcomeViewController.swift
//  YearEndBetting
//
//  Created by yongjun18 on 12/26/24.
//

import Foundation
import UIKit
import PinLayout

class WelcomeViewController: UIViewController {
    
    // MARK: - Properties
    
    private let heartCount = 10
    
    private var containerView = UIView()
    private var welcomeLabel = UILabel()
    private var welcomeButton = UIButton()
    private var heartImageViews = Array<UIImageView>()
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .black.withAlphaComponent(0.5)
        self.view.addSubview(containerView)
        
        welcomeLabel.text = "2024년 송년회에 오신 것을 환영합니다!"
        welcomeLabel.numberOfLines = 0
        welcomeLabel.font = .systemFont(ofSize: 18, weight: .semibold)
        welcomeLabel.textColor = .white
        welcomeLabel.sizeToFit()
        containerView.addSubview(welcomeLabel)
        
        for idx in 0..<heartCount {
            let imageName = "heart" + ((idx == heartCount-1) ? ".fill" : "")
            let heartImageView = UIImageView(image: UIImage(systemName: imageName))
            heartImageView.tintColor = UIColor(named: "DarkPink")
            heartImageView.contentMode = .scaleAspectFit
            if idx > 0 {
                heartImageView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0, 0)
                heartImageView.isHidden = true
            }
            containerView.addSubview(heartImageView)
            heartImageViews.append(heartImageView)
        }
        
        welcomeButton.setTitle("OK", for: .normal)
        welcomeButton.setTitleColor(.white, for: .normal)
        welcomeButton.titleLabel?.font = .systemFont(ofSize: 16, weight: .medium)
        welcomeButton.addTarget(self, action: #selector(welcomeButtonPressed), for: .touchUpInside)
        containerView.addSubview(welcomeButton)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        welcomeLabel.pin.top().left()
        for idx in heartImageViews.indices {
            heartImageViews[idx].pin.below(of: welcomeLabel, aligned: .center).size(80).marginTop(2)
        }
        welcomeButton.pin.below(of: welcomeLabel, aligned: .center).size(80)
        containerView.pin.wrapContent().center()
    }
    
}


// MARK: - Private Extensions

private extension WelcomeViewController {
    @objc func welcomeButtonPressed() {
        UIView.animate(withDuration: 0.3) {
            self.welcomeButton.alpha = 0.0
        } completion: { _ in
            self.welcomeButton.isHidden = true
        }
        
        for idx in heartImageViews.indices {
            heartImageViews[idx].isHidden = false
            UIView.animate(withDuration: 4, delay: 0.3 * Double(idx + 1)) {
                self.heartImageViews[idx].transform = CGAffineTransformScale(CGAffineTransformIdentity, 50, 50)
            }
        }
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 7.0) {
            
        }
    }
}
