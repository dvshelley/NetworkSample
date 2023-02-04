# NetworkSample

A sample app that uses **async** **await** to fetch data before automatically decoding based off the target object type. 

1. create a method that makes the network request, returning the response as a string

> let url = "https://swapi.dev/api/people/1" 
> let result:(String?, Error?) = await Networking().request(url:url)

2. Run this code and look in the debug console. You will see a `DecodingError` and a nicely formatted JSON response.

3. Either create a `struct` model for the JSON by hand or copy the JSON and use https://app.quicktype.io to generate a struct model.

4. Change your code to specify your `struct` as the response object type like this
> let url = "https://swapi.dev/api/people/1" 
> let result:(Person?, Error?) = await Networking().request(url:url)

5. the decoded object or error will be passed back

For example:

    func fetchContent() async -> Person? {
        let url = "https://swapi.dev/api/people/1"
        let result:(Person?, Error?) = await Networking().request(url: url)
        handleError(result.1)
        return result.0
    }

Written using Xcode 14.2, targeting iOS 16. This should also work with iOS 15. 
