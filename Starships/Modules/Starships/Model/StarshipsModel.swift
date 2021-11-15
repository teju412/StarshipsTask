//
//  StarshipModel.swift
//  Starships
//
//  Created by TejaDanasvi on 15/11/21.
//

import Foundation
import PromiseKit

protocol IStarshipModel {
    var starshipList: Observable<[Starship]> { get set }
    var starship: Observable<Starship?> { get set }
    var starshipIndex: Observable<Int?> { get set }
    
    func setCurrentStarshipData(index: Int)
    func starshipIsAFavorite(index: Int) -> Bool
    func selectStarshipAsFavorite(index: Int)
    func deSelectStarshipFromFavorite(index: Int)
    func loadStarships() -> Promise<Void>
}

class StarshipModel: IStarshipModel {
    
    var starshipList: Observable<[Starship]> = Observable([])
    var starship: Observable<Starship?> = Observable(nil)
    var starshipIndex: Observable<Int?> = Observable(nil)
    var apiService: IStarshipApiRepository
    
    init(apiService: IStarshipApiRepository = StarshipApiRepository()) {
        self.apiService = apiService
    }
    
    // MARK: - Loaders
    
    func loadStarships() -> Promise<Void> {
        apiService.getStarships()
        .done { self.assignStarshipList(response: $0) }
    }
    
    func assignStarshipList(response: Starships) {
        self.starshipList.value = response.results
    }
    
    func setCurrentStarshipData(index: Int) {
        self.starshipIndex.value = index
        self.starship.value = starshipList.value[index]
    }
    
    // MARK: - Favorites

    func starshipIsAFavorite(index: Int) -> Bool {
        return self.starshipList.value[index].favorite ?? false
    }
    
    func selectStarshipAsFavorite(index: Int) {
        self.starshipList.value[index].favorite = true
    }
    
    func deSelectStarshipFromFavorite(index: Int) {
        self.starshipList.value[index].favorite = false
    }
}
