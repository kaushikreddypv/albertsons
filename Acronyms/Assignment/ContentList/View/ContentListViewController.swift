//
//  ContentListViewController.swift
//  Assignment
//
//  Created by Venkata, Kaushik on 10/13/21.
//

import UIKit
import Combine


/// This class handles the content list page UI.
class ContentListViewController: UIViewController {
    
    // MARK: - IB Outlets
    
    // tableView to display  results
    @IBOutlet private weak var contentListTableView: UITableView!
    
    var resultSearchController = UISearchController()
    
    
    
    // MARK: - Variables
    
    var viewModel: ContentListViewModel
    
    private var bag = Set<AnyCancellable>()
    
    
    
    // MARK: - Dependencies
    
    init(viewModel: ContentListViewModel) {
        self.viewModel = viewModel
        super.init(nibName: String(describing: ContentListViewController.self), bundle: Bundle.main)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - View Life Cycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Contents"
        registerTableViewCell()
        bindViewModel()
        setupSearchBar()
        
    }
    
    private func setupSearchBar() {
        self.resultSearchController = ({
            let controller = UISearchController(searchResultsController: nil)
            controller.searchResultsUpdater = self
            controller.searchBar.sizeToFit()
            controller.searchBar.barStyle = UIBarStyle.black
            controller.searchBar.barTintColor = UIColor.white
            controller.searchBar.backgroundColor = UIColor.white
            self.contentListTableView.tableHeaderView = controller.searchBar
            return controller
        })()
    }
    
    
    // MARK: - Private custom methods
    
    
    // binds the ViewModel to controller
    private func bindViewModel() {
        viewModel.updateViewSubject.sink {  [weak self] in
            ActivityManager.sharedInstance.hideActivityIndicator()
            self?.contentListTableView.reloadData()
        }
        .store(in: &bag)
        
    }
    
    /// register tableViewcell and row height estimation
    private func registerTableViewCell() {
        contentListTableView.register(ContentListTableViewCell.nib,
                                      forCellReuseIdentifier: ContentListTableViewCell.identifier)
        contentListTableView.rowHeight = UITableView.automaticDimension
        contentListTableView.estimatedRowHeight = 80
        
    }
    
    
}


// MARK: - Exetnsions
// MARK: - UITableViewDelegate
// MARK: - UITableViewDataSource


extension ContentListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.lfsCount
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }
    
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ContentListTableViewCell.identifier)  as? ContentListTableViewCell else {
            fatalError()
        }
        cell.lf = viewModel.lfs(atIndex: indexPath.section)
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    
}

extension ContentListViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        viewModel.getAcromine(text: searchController.searchBar.text ?? "")
    }
    
    
}
