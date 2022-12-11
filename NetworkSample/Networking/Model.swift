//
//  Model.swift
//  NetworkSample
//
//  Created by Daniel Shelley on 12/10/22.
//

import Foundation

// MARK: - create the request URL

enum Endpoint {
    case allByZip(zip: String)
    case repsByState(state: String)
    case repsByName(name: String)
    case senatorByState(state: String)
    case senatorByName(name: String)
}

extension Endpoint {
    var url: String {
        switch self {
        case .allByZip(let zip):
            return "https://whoismyrepresentative.com/getall_mems.php?zip=\(zip)&output=json"
        case .repsByState(let state):
            return "https://whoismyrepresentative.com/getall_reps_bystate.php?state=\(state)&output=json"
        case .repsByName(let name):
            return "https://whoismyrepresentative.com/getall_reps_byname.php?name=\(name)&output=json"
        case .senatorByState(let state):
            return "https://whoismyrepresentative.com/getall_sens_bystate.php?state=\(state)&output=json"
        case .senatorByName(let name):
            return "https://whoismyrepresentative.com/getall_sens_byname.php?name=\(name)&output=json"
        }
    }
}

// MARK: - decoder

struct CongressMembers: Decodable {
    let results: [Representative]
}

struct Representative: Decodable {
    let name: String
    let party: String
    let state: String
    let district: String
    let phone: String
    let office: String
    let link: String
}
