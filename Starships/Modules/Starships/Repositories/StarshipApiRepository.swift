//
//  StarshipApiRepository.swift
//  Starships
//
//  Created by TejaDanasvi on 14/11/21.
//

import PromiseKit
import Alamofire
import Foundation

protocol IStarshipApiRepository {
    func getStarships() -> Promise<Starships>
}

final class StarshipApiRepository: IStarshipApiRepository {
    func getStarships() -> Promise<Starships> {
        return Promise<Starships> { seal in
            AF.request(ApiUrls.starships, method: .get).responseDecodable { (response: DataResponse<Starships, AFError>) in
                switch response.result {
                    case .success(let value):
                        print(value.results[0])
                        seal.fulfill(value)
                    case .failure(let value):
                        seal.reject(value)
                }
            }
        }
    }
}

struct Starships: Codable {
    var results: [Starship]
}

struct Starship: Codable {
    var name: String?
    var model: String?
    var manufacturer: String?
    var costInCredits: String?
    var length: String?
    var maxAtmospheringSpeed: String?
    var crew: String?
    var passengers: String?
    var cargoCapacity: String?
    var consumables: String?
    var hyperdriveRating: String?
    var MGLT: String?
    var starshipClass: String?
    var films: [String]?
    var created: String?
    var edited: String?
    var url: String?
    var favorite: Bool?
    
    private enum CodingKeys: String, CodingKey {
        case name
        case model
        case manufacturer
        case costInCredits = "cost_in_credits"
        case length
        case maxAtmospheringSpeed = "max_atmosphering_speed"
        case crew
        case passengers
        case cargoCapacity = "cargo_capacity"
        case consumables
        case hyperdriveRating = "hyperdrive_rating"
        case MGLT
        case starshipClass = "starship_class"
        case films
        case created
        case edited
        case url
        case favorite
    }
}
