//
//  StarshipListViewController.swift
//  Starships
//
//  Created by TejaDanasvi on 14/11/21.
//

import UIKit
import SwiftyGif

class StarshipListViewController: UIViewController {
    
    @IBOutlet weak var errorView: UIView!
    @IBOutlet weak var retryButton: UIButton!
    @IBOutlet weak var loadingView: UIView!
    @IBOutlet weak var loaderImage: UIView!
    @IBOutlet weak var starshipTableView: UITableView! {
        didSet {
            let nib = UINib(nibName: "StarshipTableViewCell", bundle: nil)
            starshipTableView.register(nib, forCellReuseIdentifier: "StarshipTableViewCell")
            starshipTableView.showsVerticalScrollIndicator = false
            starshipTableView.delegate = self
            starshipTableView.dataSource = self
            starshipTableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        }
    }
    
    var model: IStarshipModel
    var viewModel: IStarshipListViewModel
    
    init(model: IStarshipModel = StarshipModel()) {
        self.model = model
        self.viewModel = StarshipListViewModel(model: self.model)
        super.init(nibName: "StarshipListViewController", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.loadData()
        viewModel.starshipList.bind { _ in
            DispatchQueue.main.async { self.starshipTableView.reloadData() }
        }
    }
    
    @IBAction func onRetryPressed(_ sender: UIButton) {
        self.loadData()
    }
    
    // MARK: - Loaders
    
    func loadData() {
        self.showLoader()
        self.viewModel.loadData()
            .done { self.showTable() }
            .done { self.starshipTableView.reloadData() }
            .catch { _ in self.showError() }
    }
    
    // MARK: - Show and hide
    
    func showError() {
        self.title = ""
        starshipTableView.isHidden = true
        loadingView.isHidden = true
        errorView.isHidden = false
    }
    
    func showLoader() {
        self.title = ""
        do {
            let gif = try UIImage(gifName: "Spinner.gif")
            let imageview = UIImageView(gifImage: gif, loopCount: -1)
            imageview.frame = loaderImage.bounds
            loaderImage.addSubview(imageview)
        }
        catch { print(error) }
        starshipTableView.isHidden = true
        loadingView.isHidden = false
        errorView.isHidden = true
    }
    
    func showTable() {
        self.title = "Starships"
        starshipTableView.isHidden = false
        loadingView.isHidden = true
        errorView.isHidden = true
    }
    
    // MARK: - Favourites Toggle
    
    func toggleStarshipAsFavourite(index: Int) {
        self.viewModel.toggleStarshipAsFavorite(index: index)
        self.viewModel.loadStarshipsList()
        self.starshipTableView.reloadData()
    }
    
    // MARK: - Navigation
    
    func navigateToDetailsPage() {
        let vm = StarshipDetailsViewModel(model: self.model)
        let vc = StarshipDetailsViewController(viewModel: vm)
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension StarshipListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.starshipList.value.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell: StarshipTableViewCell = starshipTableView.dequeueReusableCell(withIdentifier: "StarshipTableViewCell", for: indexPath) as? StarshipTableViewCell else { return UITableViewCell() }
        cell.configure(starshipCellVM: self.viewModel.starshipList.value[indexPath.row],
                       delegate: self,
                       indexPath: indexPath)
        return cell
    }
}

extension StarshipListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.setCurrentStarship(index: indexPath.row)
        navigateToDetailsPage()
    }
}
