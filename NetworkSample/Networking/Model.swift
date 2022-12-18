//
//  Model.swift
//  NetworkSample
//
//  Created by Daniel Shelley on 12/10/22.
//

import Foundation

// MARK: - create the request URL

enum Endpoint {
    /// returns Senators and Representatives for a specific zipcode; e.g. 31023
    case allByZip(zip: String)
    /// returns Representatives for a state; e.g. "NV"
    case repsByState(state: String)
    /// returns Representatives for a state by name; e.g. "smith"
    case repsByName(name: String)
    /// returns Senators for a state; e.g. "NV"
    case senatorByState(state: String)
    /// returns Senators by name; e.g. "johnson"
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
