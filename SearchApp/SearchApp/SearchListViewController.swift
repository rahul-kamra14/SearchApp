//
//  SearchListViewController.swift
//  SearchApp
//
//  Created by Rahul Kamra on 25/04/21.
//

import UIKit

class SearchListViewController: UIViewController {
    
    let viewModel = SearchListViewModel(service: Service())
    let spinner = SpinnerViewController()
    
    lazy var baseStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false

        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.spacing = 0
        stackView.layoutMargins = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        stackView.isLayoutMarginsRelativeArrangement = true
        return stackView
    }()
    
    lazy var textFieldContainerView: UIView = {
        let container = UIView()
        container.addSubview(inputTextField)
        container.addSubview(textFieldLineView)
        container.heightAnchor.constraint(equalToConstant: 50).isActive = true
        textFieldLineView.bottomAnchor.constraint(equalTo: container.bottomAnchor).isActive = true
        textFieldLineView.leadingAnchor.constraint(equalTo: container.leadingAnchor).isActive = true
        textFieldLineView.trailingAnchor.constraint(equalTo: container.trailingAnchor).isActive = true
        inputTextField.leadingAnchor.constraint(equalTo: container.leadingAnchor).isActive = true
        inputTextField.trailingAnchor.constraint(equalTo: container.trailingAnchor).isActive = true
        inputTextField.bottomAnchor.constraint(equalTo: textFieldLineView.topAnchor).isActive = true
        return container
    }()
    
    lazy var textFieldLineView: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        view.heightAnchor.constraint(equalToConstant: 1).isActive = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var inputTextField: UITextField = {
        let textField = UITextField(frame: .zero)
        textField.placeholder = "Search Cities"
        textField.borderStyle = .none
        textField.autocorrectionType = .no
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    lazy var searchButtonContainerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(searchButton)
        view.heightAnchor.constraint(equalToConstant: 80).isActive = true
        self.searchButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        self.searchButton.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        return view
    }()
    
    lazy var searchButton: UIButton = {
        let button = UIButton()
        button.setTitle("Search", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(searchAction(_:)), for: .touchUpInside)

        button.heightAnchor.constraint(equalToConstant: 40).isActive = true
        button.widthAnchor.constraint(equalToConstant: 70).isActive = true
        button.layer.borderWidth = 1.0
        button.layer.borderColor = UIColor.systemBlue.cgColor
        button.layer.cornerRadius = 4.0
        return button
    }()
    
    lazy var lineView: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        view.heightAnchor.constraint(equalToConstant: 1).isActive = true
        return view
    }()
    
    lazy var searchTableView: UITableView = {
        let view = UITableView()
        view.dataSource = self
        view.separatorStyle = .none
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Search"
        setUpUI()
        searchTableView.register(UINib(nibName: String(describing: SearchTableCell.self), bundle: Bundle.main), forCellReuseIdentifier: String(describing: SearchTableCell.self))
        
        viewModel.shouldReloadTableView = { [weak self] (shouldReload) in
            DispatchQueue.main.async {
                self?.removeHUD()
                if shouldReload {
                    self?.searchTableView.reloadData()
                }else {
                    //handle error
                }
            }
        }
    }
    
    func setUpUI() {
        self.view.addSubview(baseStackView)
        let margins = self.view.layoutMarginsGuide
        baseStackView.topAnchor.constraint(equalTo: margins.topAnchor).isActive = true
        baseStackView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        baseStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        baseStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        baseStackView.addArrangedSubview(textFieldContainerView)
        baseStackView.addArrangedSubview(searchButtonContainerView)
        baseStackView.addArrangedSubview(lineView)
        baseStackView.addArrangedSubview(searchTableView)
    }
    
    func searchResults(_ text: String) {
        addHUD()
        //call API on Background thread
        viewModel.fetchSearchResults(text)
    }
    
    @objc func searchAction(_: UIButton) {
        guard let text = inputTextField.text else {
            //show error
            return
        }
        searchResults(text)
    }
}

extension SearchListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.dataArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell: SearchTableCell = tableView.dequeueReusableCell(withIdentifier: String(describing: SearchTableCell.self)) as? SearchTableCell else { return UITableViewCell()
        }
        cell.configure(data: viewModel.dataArray[indexPath.row])
        return cell
    }
}

extension SearchListViewController {
    func addHUD() {
        addChild(spinner)
        spinner.view.frame = view.frame
        view.addSubview(spinner.view)
        spinner.didMove(toParent: self)
    }
    
    func removeHUD() {
        spinner.willMove(toParent: nil)
        spinner.view.removeFromSuperview()
        spinner.removeFromParent()
    }
}
