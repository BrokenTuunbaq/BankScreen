import Foundation

struct StockModel: Codable {
    let time: String
    let open: String
    let high: String
    let low: String
    let close: String
    let volume: String
    
    private enum CodingKeys: String, CodingKey {
        case time = "time"
        case open = "1. open"
        case high = "2. high"
        case low = "3. low"
        case close = "4. close"
        case volume = "5. volume"
    }

    func timeFormat(dateString: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let date = dateFormatter.date(from: dateString)
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm:ss"
        return formatter.string(from: date!)
    }
}
