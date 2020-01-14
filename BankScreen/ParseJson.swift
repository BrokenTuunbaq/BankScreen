import Foundation

struct ParseJson {
    func parse(jsonString: String) -> [BankModel] {
        do {
            let f = try JSONDecoder().decode([BankModel].self, from: jsonString.data(using: .utf8)!)
            return f
        } catch {
            print(error)
        }
        return [BankModel]()
    }
    
    func parseStock(jsonData: Data) -> [StockModel] {
        do {
            if let json = try JSONSerialization.jsonObject(with: jsonData, options: []) as? [String: Any] {
                let keyTimeSeries = searchKeyByString(searchStr: ConstantStrings.TIME_SERIES_STRING, dictionary: json)
            
                guard let jsonKeyTimeSeries = json[keyTimeSeries] as! [String: Any]? else {
                    return [StockModel]()
                }
                return stockArray(dictionary: jsonKeyTimeSeries as! [String: [String: String]])
            }
        } catch { }
        return [StockModel]()
    }
    
    func searchKeyByString(searchStr: String, dictionary: [String: Any]) -> String {
        for (key, _) in dictionary {
            if key.contains(searchStr) {
                return key
            }
        }
        return ""
    }
    
    func stockArray(dictionary: [String: [String: String]]) -> [StockModel] {
        var stockModelArray = [StockModel]()
        
        for (time, stockDict) in dictionary {
            do {
                var stockDictWithTime = stockDict
                stockDictWithTime["time"] = time
                
                let json = try JSONSerialization.data(withJSONObject: stockDictWithTime)
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let decodedStock = try decoder.decode(StockModel.self, from: json)
                stockModelArray.append(decodedStock)
            } catch {
                print(error)
            }
        }
        return sortStocksByTime(stockArray: stockModelArray)
    }
    
    func sortStocksByTime(stockArray: [StockModel]) -> [StockModel] {
        return stockArray.sorted(by: { $0.time < $1.time })
    }
}
