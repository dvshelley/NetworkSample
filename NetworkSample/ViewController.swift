//
//  ViewController.swift
//  NetworkSample
//
//  Created by Daniel Shelley on 12/10/22.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var rowData:[Representative] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UINib(nibName: "TableCell", bundle: nil), forCellReuseIdentifier: TableCell.identifier)
        
        fetchData()
    }
    
    func fetchData(_ forceReload:Bool = false) {
        guard forceReload || rowData.isEmpty else { return }
        Task {
            let rowData = await fetchRepresentatives()
            self.rowData = rowData
            self.tableView.reloadData()
        }
    }

    func fetchRepresentatives() async -> [Representative] {
        let url = Endpoint.allByZip(zip: "31023").url
        let result:(CongressMembers?, Error?) = await Networking().request(url: url)
        handleError(result.1)
        return result.0?.results ?? []
    }
    
    func fetchRepresentativesByRequest() async -> [Representative] {
        let url = URL(string:Endpoint.allByZip(zip: "31023").url)!
        let request = URLRequest(url:url)
        let result: (CongressMembers?, Error?) = await Networking().request(request)
        handleError(result.1)
        return result.0?.results ?? []
    }
    
    func handleError(_ error:Error?) {
        guard let messageString = error?.localizedDescription else { return }
        let alert = UIAlertController(title: messageString, message: nil, preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(ok)
        self.present(alert, animated: true, completion: nil)
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        rowData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = rowData[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: TableCell.identifier, for: indexPath) as! TableCell
        cell.configure(item)
        return cell
    }
}
