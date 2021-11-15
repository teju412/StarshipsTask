//
//  StarshipDetailsViewModel.swift
//  Starships
//
//  Created by TejaDanasvi on 15/11/21.
//
import Foundation
import PromiseKit

protocol IStarshipDetailsViewModel {
    var starship: Observable<Starship?> { get set }
    var starshipIndex: Observable<Int?> { get set }
    var model: IStarshipModel { get set }
    
    func getStarship()
    func toggleStarshipAsFavorite()
}

class StarshipDetailsViewModel: IStarshipDetailsViewModel {
    
    var starship: Observable<Starship?> = Observable(nil)
    var starshipIndex: Observable<Int?> = Observable(nil)
    var model: IStarshipModel
    
    init(model: IStarshipModel = StarshipModel()) {
        self.model = model
        self.getStarship()
        self.model.starship.bind { _ in
            DispatchQueue.main.async { self.getStarship() }
        }
        self.model.starshipIndex.bind { _ in
            DispatchQueue.main.async { self.getStarship() }
        }
    }
    
    // MARK: - Loaders
    
    func getStarship() {
        self.starship.value = model.starship.value
        self.starshipIndex.value = model.starshipIndex.value
    }
    
    // MARK: - Favourites
    
    func toggleStarshipAsFavorite() {
        guard let index = starshipIndex.value else { return }
        if self.model.starshipIsAFavorite(index: index) {
            self.starship.value?.favorite = false
            self.model.deSelectStarshipFromFavorite(index: index)
        } else {
            self.starship.value?.favorite = true
            self.model.selectStarshipAsFavorite(index: index)
        }
    }
}
