//
//  ViewController.swift
//  NetworkSample
//
//  Created by Daniel Shelley on 12/10/22.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var members:[Representative] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UINib(nibName: "TableCell", bundle: nil), forCellReuseIdentifier: TableCell.identifier)
        
        Task {
            let members = await fetchRepresentatives()
            self.members = members
            self.tableView.reloadData()
        }
    }

    func fetchRepresentatives() async -> [Representative] {
        let url = Endpoint.allByZip(zip: "31023").url
//        let url = Endpoint.repsByName(name: "smith").url
//        let url = Endpoint.repsByState(state: "NV").url
//        let url = Endpoint.senatorByName(name: "johnson").url
//        let url = Endpoint.senatorByState(state: "ME").url
        
        let result:CongressMembers? = await Networking().request(url: url)
        return result?.results ?? []
    }
    
    func fetchRepresentativesByRequest() async -> [Representative] {
        let url = URL(string:Endpoint.allByZip(zip: "31023").url)!
        let request = URLRequest(url:url)
        let result:CongressMembers? = await Networking().request(request)
        return result?.results ?? []
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        members.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let member = members[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: TableCell.identifier, for: indexPath) as! TableCell
        cell.configure(member: member)
        return cell
    }
}
