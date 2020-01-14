import Foundation

struct BankModel: Codable {
    let name: String
    let stk: String
    let img: String
    let priority: String
    
    private enum CodingKeys: String, CodingKey {
        case name = "name"
        case stk = "stk"
        case img = "img"
        case priority = "priority"
    }
}
