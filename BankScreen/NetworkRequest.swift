import Foundation

protocol NetworkRequestDelegate {
    func stocksReceived(stocksArray: [StockModel])
}

class NetworkRequest {
    
    var delegate:NetworkRequestDelegate?
    
    func getStocks(symbol: String, interval: String, apiKey: String) -> Void {
        let urlStock = URL(string:  RuntimeStorage.baseUrl + symbol + "&interval=" + interval + "&apikey=" + apiKey)!
        var request = URLRequest(url: urlStock as URL)
        request.httpMethod = "GET"
        let configuration = URLSessionConfiguration.default
        let session = URLSession(configuration: configuration)
        
        let task = session.dataTask(with: request) {
            data, response, error in
            guard let data = data, error == nil else {
                print(error?.localizedDescription ?? "No data")
                return
            }
            let stockArray = ParseJson().parseStock(jsonData: data)
            self.delegate?.stocksReceived(stocksArray: stockArray)
        }
        task.resume()
    }
}
