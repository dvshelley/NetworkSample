# NetworkSample

A sample app that uses **async** **await** to fetch data before automatically decoding based off the target object type. For example:

    func fetchRepresentatives() async -> [Representative] {
        let url = Endpoint.allByZip(zip: "31023").url
        let result:CongressMembers? = await Networking().request(url: url)
        return result?.results ?? []
    }

Written using Xcode 14.1, targeting iOS 16. Should also work with IOS 15. 
