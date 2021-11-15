//
//  StarshipListViewModel.swift
//  Starships
//
//  Created by TejaDanasvi on 14/11/21.
//
import Foundation
import PromiseKit

protocol IStarshipListViewModel {
    var starshipList: Observable<[StarshipTableViewCellVM]> { get set }
    var model: IStarshipModel { get set }
    
    func loadData() -> Promise<Void>
    func loadStarshipsList()
    func toggleStarshipAsFavorite(index: Int)
    func setCurrentStarship(index: Int)
}


class StarshipListViewModel: IStarshipListViewModel {
    var starshipList: Observable<[StarshipTableViewCellVM]> = Observable([])
    var model: IStarshipModel
    
    init(model: IStarshipModel = StarshipModel()) {
        self.model = model
        self.model.starshipList.bind { _ in
            DispatchQueue.main.async { self.loadStarshipsList() }
        }
    }
    
    // MARK: - Loaders
    
    func loadData() -> Promise<Void> {
        self.model.loadStarships()
            .done{ self.loadStarshipsList() }
    }
    
    func loadStarshipsList() {
        self.starshipList.value = self.model.starshipList.value.enumerated().map { (index,starship) in
            return StarshipTableViewCellVM(starshipName: starship.name ?? "",
                                           modelName: starship.model ?? "",
                                           manufacturer: starship.manufacturer ?? "",
                                           isFav: starship.favorite ?? false)
        }
    }
    
    // MARK: - Favourites
    
    func toggleStarshipAsFavorite(index: Int) {
        if self.model.starshipIsAFavorite(index: index) {
            self.model.deSelectStarshipFromFavorite(index: index)
        } else {
            self.model.selectStarshipAsFavorite(index: index)
        }
    }
    
    func setCurrentStarship(index: Int) {
        self.model.setCurrentStarshipData(index: index)
    }
}
