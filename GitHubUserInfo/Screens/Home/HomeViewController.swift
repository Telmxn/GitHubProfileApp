//
//  HomeViewController.swift
//  GitHubUserInfo
//
//  Created by Telman Yusifov on 17.05.25.
//

import UIKit
import Kingfisher

final class HomeViewController: BaseViewController {
    
    private var mainStackView: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.alignment = .center
        view.spacing = 40
        return view
    }()
    
    private var formStackView: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.spacing = 26
        return view
    }()
    
    private var usernameTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Write username"
        textField.text = "telmxn"
        textField.backgroundColor = .redBackground
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.redBorder.cgColor
        textField.textColor = .white
        textField.textAlignment = .center
        return textField
    }()
    
    private lazy var searchButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Search", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .blueBackground
        button.layer.borderColor = UIColor.blueBorder.cgColor
        button.layer.borderWidth = 1
        button.addTarget(self, action: #selector(didTapSearchButton), for: .touchUpInside)
        return button
    }()
    
    private var userInfoStackView: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.alignment = .center
        view.spacing = 4
        return view
    }()
    
    private var avatarImageView: UIImageView = {
        let view = UIImageView()
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.darkGray.cgColor
        view.layer.cornerRadius = 75
        view.clipsToBounds = true
        return view
    }()
    
    private var nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        label.textAlignment = .center
        return label
    }()
    
    private var bioLabel: UILabel = {
        let label = UILabel()
        label.text = "Bio"
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        label.textAlignment = .center
        return label
    }()
    
    private var bioView: UIView = {
        let view = UIView()
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.darkGray.cgColor
        return view
    }()
    
    private var bioStackView: UIStackView = {
        let view = UIStackView()
        view.axis = .horizontal
        view.distribution = .fillEqually
        return view
    }()
    
    private var followerLabel: BioLabel = BioLabel()
    
    private var followingLabel: BioLabel = BioLabel()
    
    private var publicReposLabel: BioLabel = BioLabel()

    private let viewModel: HomeViewModel
    
    init(viewModel: HomeViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    @MainActor required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        viewModel.subscribe(self)
        
        viewModel.fetchData(username: "telmxn")
    }

    private func setupUI() {
        view.addSubview(mainStackView)
        [usernameTextField, searchButton].forEach(formStackView.addArrangedSubview)
        [avatarImageView, nameLabel, bioLabel, bioView].forEach(userInfoStackView.addArrangedSubview)
        bioView.addSubview(bioStackView)
        [followerLabel, followingLabel, publicReposLabel].forEach(bioStackView.addArrangedSubview)
        [formStackView, userInfoStackView].forEach(mainStackView.addArrangedSubview)
        
        mainStackView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.horizontalEdges.equalToSuperview().inset(20)
        }
        
        formStackView.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview()
        }
        
        usernameTextField.snp.makeConstraints { make in
            make.height.equalTo(30)
        }
        
        searchButton.snp.makeConstraints { make in
            make.height.equalTo(30)
        }
        
        avatarImageView.snp.makeConstraints { make in
            make.size.equalTo(150)
        }
        
        userInfoStackView.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview()
        }
        
        bioView.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview()
        }
        
        bioStackView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(30)
        }
    }
    
    @objc
    private func didTapSearchButton() {
        if usernameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) != "" {
            viewModel.fetchData(username: usernameTextField.text ?? "")
        }
    }
}

extension HomeViewController: HomeDelegate {
    func render(_ state: HomeState) {
        switch state {
        case .loading:
            print("Loading")
        case .loaded(let githubUser):
            DispatchQueue.main.async {
                self.avatarImageView.downloadSetImage(url: githubUser.avatar_url)
                self.nameLabel.text = githubUser.name
                self.publicReposLabel.text = "\(githubUser.public_repos) public repos"
                self.followerLabel.text = "\(githubUser.followers) followers"
                self.followingLabel.text = "\(githubUser.following) following"
            }
        case .error(let error):
            if error.message == "Not Found" {
                DispatchQueue.main.async {
                    self.avatarImageView.image = UIImage(systemName: "person.fill")
                    self.nameLabel.text = "Not Found"
                    self.publicReposLabel.text = "0 public repos"
                    self.followerLabel.text = "0 followers"
                    self.followingLabel.text = "0 following"
                }
            }
        }
    }
}
