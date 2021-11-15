//
//  StarshipDetailsViewController.swift
//  Starships
//
//  Created by TejaDanasvi on 14/11/21.
//
import UIKit

class StarshipDetailsViewController: UIViewController {
    
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var model: UILabel!
    @IBOutlet weak var manufacturer: UILabel!
    @IBOutlet weak var costInCredits: UILabel!
    @IBOutlet weak var length: UILabel!
    @IBOutlet weak var maxAtmospheringSpeed: UILabel!
    @IBOutlet weak var crew: UILabel!
    @IBOutlet weak var passengers: UILabel!
    @IBOutlet weak var cargoCapacity: UILabel!
    @IBOutlet weak var consumables: UILabel!
    @IBOutlet weak var hyperdriveRating: UILabel!
    @IBOutlet weak var mglt: UILabel!
    @IBOutlet weak var starshipClass: UILabel!
    @IBOutlet weak var favStar: UIImageView!
    
    var viewModel: IStarshipDetailsViewModel
    
    init(viewModel: IStarshipDetailsViewModel = StarshipDetailsViewModel()) {
        self.viewModel = viewModel
        super.init(nibName: "StarshipDetailsViewController", bundle: nil)
        self.viewModel.starship.bind { _ in
            DispatchQueue.main.async { self.setup() }
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewModel.getStarship()
        self.setup()
    }
    
    func setup() {
        self.name.text = viewModel.starship.value?.name ?? ""
        self.model.text = viewModel.starship.value?.model ?? ""
        self.manufacturer.text = viewModel.starship.value?.manufacturer ?? ""
        self.costInCredits.text = viewModel.starship.value?.costInCredits ?? ""
        self.length.text = viewModel.starship.value?.length ?? ""
        self.maxAtmospheringSpeed.text = viewModel.starship.value?.maxAtmospheringSpeed ?? ""
        self.crew.text = viewModel.starship.value?.crew ?? ""
        self.passengers.text = viewModel.starship.value?.passengers ?? ""
        self.cargoCapacity.text = viewModel.starship.value?.cargoCapacity ?? ""
        self.consumables.text = viewModel.starship.value?.consumables ?? ""
        self.hyperdriveRating.text = viewModel.starship.value?.hyperdriveRating ?? ""
        self.mglt.text = viewModel.starship.value?.MGLT ?? ""
        self.starshipClass.text = viewModel.starship.value?.starshipClass ?? ""
        self.favStar.image = (viewModel.starship.value?.favorite ?? false) ? UIImage(named: "favourite-filled") : UIImage(named: "favourite-empty")
        self.favStar.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onFavStarPressed)))
    }
    
    @objc func onFavStarPressed() {
        viewModel.toggleStarshipAsFavorite()
    }
}


