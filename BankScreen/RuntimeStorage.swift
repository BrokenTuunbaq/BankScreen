import Foundation

struct RuntimeStorage {
    static var bankSymbol = "JPM"
    static var stockArray = [StockModel]()
    static let apiKey = "Z8EW6CI3PHR9SUTK"
    static let baseUrl = "https://www.alphavantage.co/query?function=TIME_SERIES_INTRADAY&symbol="
}

struct ConstantStrings {
    static let ONE_MINUTE = "1min"
    static let FIVE_MINUTE = "5min"
    static let FIFTEEN_MINUTE = "15min"
    static let THIRTY_MINUTE = "30min"
    static let SIXTY_MINUTE = "60min"
    static let TIME_SERIES_STRING = "Time Series"
}
