# NetworkSample

A sample app that uses **async** **await** to fetch data before automatically decoding based off the target object type. 

1. create a model Struct to `JSONDecoder().decode()` your response
2. pass the url into the networking class `let result:(CongressMembers?, Error?) = await Networking().request(url: url)`
3. the decoded data or error will be passed back

For example:

    func fetchContent() async -> CongressMembers? {
        let url = "https://whoismyrepresentative.com/getall_mems.php?zip=31023&output=json"
        let result:(CongressMembers?, Error?) = await Networking().request(url: url)
        handleError(result.1)
        return result.0
    }

Written using Xcode 14.1, targeting iOS 16. Should also work with IOS 15. 
