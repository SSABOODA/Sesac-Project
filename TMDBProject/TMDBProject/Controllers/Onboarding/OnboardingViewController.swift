//
//  OnboardingViewController.swift
//  TMDBProject
//
//  Created by 한성봉 on 2023/08/25.
//

import UIKit
import SnapKit

class FirstViewController: UIViewController {
    
    let label: UILabel = {
        let lb = UILabel()
        lb.text = "첫번째 온보딩 페이지"
        lb.textAlignment = .center
        lb.textColor = .black
        lb.font = .boldSystemFont(ofSize: 20)
        return lb
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .brown
        
        view.addSubview(label)
        label.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
}

class SecondViewController: UIViewController {
    
    let label: UILabel = {
        let lb = UILabel()
        lb.text = "두번째 온보딩 페이지"
        lb.textAlignment = .center
        lb.textColor = .black
        lb.font = .boldSystemFont(ofSize: 20)
        return lb
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .purple
        view.addSubview(label)
        label.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
}

class ThirdViewController: UIViewController {
    
    let label: UILabel = {
        let lb = UILabel()
        lb.text = "마지막 온보딩 페이지"
        lb.textAlignment = .center
        lb.textColor = .black
        lb.font = .boldSystemFont(ofSize: 20)
        return lb
    }()
    
    let startButton: UIButton = {
        let bnt = UIButton()
        bnt.setTitle("시작하기", for: .normal)
        bnt.backgroundColor = .systemBlue
        bnt.tintColor = .white
        bnt.layer.cornerRadius = 10
        bnt.clipsToBounds = true
        return bnt
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemMint
        view.addSubview(label)
        label.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        view.addSubview(startButton)
        startButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide).offset(-30)
            make.height.equalTo(50)
            make.width.equalTo(130)
        }
        
        startButton.addTarget(self, action: #selector(startButtonClicked), for: .touchUpInside)
    }
    
    @objc func startButtonClicked() {
        print(#function)
        UserDefaults.standard.set(true, forKey: "isOnboarding")
        
        let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
        let sceneDelegate = windowScene?.delegate as? SceneDelegate
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "TrendViewController") as! TrendViewController
        let nav = UINavigationController(rootViewController: vc)
        sceneDelegate?.window?.rootViewController = nav
        sceneDelegate?.window?.makeKey()
    }
}

class OnboardingViewController: UIPageViewController {

    var onboardingViewList = [UIViewController]()
    
    override init(transitionStyle style: UIPageViewController.TransitionStyle, navigationOrientation: UIPageViewController.NavigationOrientation, options: [UIPageViewController.OptionsKey : Any]? = nil) {
        super.init(transitionStyle: .scroll, navigationOrientation: .horizontal)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .lightGray
        onboardingViewList = [
            FirstViewController(),
            SecondViewController(),
            ThirdViewController(),
        ]
        
        delegate = self
        dataSource = self
        
        guard let first = onboardingViewList.first else { return }
        setViewControllers([first], direction: .forward, animated: true)
    }
}


extension OnboardingViewController: UIPageViewControllerDelegate & UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let currentIndex = onboardingViewList.firstIndex(of: viewController) else { return nil }
        let previousIndex = currentIndex - 1
        return previousIndex < 0 ? nil : onboardingViewList[previousIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let currentIndex = onboardingViewList.firstIndex(of: viewController) else { return nil }
        let nextIndex = currentIndex + 1
        return nextIndex >= onboardingViewList.count ? nil : onboardingViewList[nextIndex]
    }
    
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return onboardingViewList.count
    }
    
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        guard let first = viewControllers?.first, let index = onboardingViewList.firstIndex(of: first) else { return 0 }
        return index
    }
    
}
