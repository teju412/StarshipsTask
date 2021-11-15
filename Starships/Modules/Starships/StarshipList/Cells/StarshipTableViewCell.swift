//
//  StarshipTableViewCell.swift
//  Starships
//
//  Created by TejaDanasvi on 14/11/21.
//
import UIKit

class StarshipTableViewCell: UITableViewCell {

    @IBOutlet weak var starshipName: UILabel!
    @IBOutlet weak var modelName: UILabel!
    @IBOutlet weak var manufacturer: UILabel!
    @IBOutlet weak var favStar: UIImageView!
    var delegate: StarshipListViewController?
    var indexPath: IndexPath?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func configure(starshipCellVM: StarshipTableViewCellVM, delegate: StarshipListViewController, indexPath: IndexPath) {
        self.delegate = delegate
        self.indexPath = indexPath
        self.starshipName.text = starshipCellVM.starshipName
        self.modelName.text = starshipCellVM.modelName
        self.manufacturer.text = starshipCellVM.manufacturer
        self.favStar.image = starshipCellVM.isFav ? UIImage(named: "favourite-filled") : UIImage(named: "favourite-empty")
        self.favStar.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onFavStarPressed)))
    }
    
    @objc func onFavStarPressed() {
        guard let delegate = self.delegate, let row = self.indexPath?.row else { return }
        delegate.toggleStarshipAsFavourite(index: row)
    }
}

struct StarshipTableViewCellVM {
    let starshipName: String
    let modelName: String
    let manufacturer: String
    let isFav: Bool
}
