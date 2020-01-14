import UIKit

class StockViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, NetworkRequestDelegate {
    
    @IBOutlet weak var rightBarButton: UIBarButtonItem!
    @IBOutlet weak var one_minButton: UIButton!
    @IBOutlet weak var five_minButton: UIButton!
    @IBOutlet weak var fifteen_minButton: UIButton!
    @IBOutlet weak var thirty_minButton: UIButton!
    @IBOutlet weak var sixty_minButton: UIButton!
    @IBOutlet weak var stockTable: UITableView!
    var stockArray = [StockModel]()
    var networkRequest = NetworkRequest()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        rightBarButton.isEnabled = false
        stockTable.delegate = self
        stockTable.dataSource = self
        networkRequest.delegate = self
        
        requestStocks(bankSymbol: RuntimeStorage.bankSymbol, interval: ConstantStrings.ONE_MINUTE)
    }
    
    @IBAction func one_minPressed(_ sender: Any) {
        switchButtonValue(valuePressed: ConstantStrings.ONE_MINUTE)
    }
    
    @IBAction func five_minPressed(_ sender: Any) {
        switchButtonValue(valuePressed: ConstantStrings.FIVE_MINUTE)
    }
    
    @IBAction func fifteen_minPressed(_ sender: Any) {
        switchButtonValue(valuePressed: ConstantStrings.FIFTEEN_MINUTE)
    }
    
    @IBAction func thirty_minPressed(_ sender: Any) {
        switchButtonValue(valuePressed: ConstantStrings.THIRTY_MINUTE)
    }
    
    @IBAction func sixty_minPressed(_ sender: Any) {
        switchButtonValue(valuePressed: ConstantStrings.SIXTY_MINUTE)
    }
    
    func switchButtonValue(valuePressed: String) {
        requestStocks(bankSymbol: RuntimeStorage.bankSymbol, interval: valuePressed)
    }
    
    func requestStocks(bankSymbol: String, interval: String) {
        networkRequest.getStocks(symbol: bankSymbol, interval: interval, apiKey: RuntimeStorage.apiKey)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return stockArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = stockTable.dequeueReusableCell(withIdentifier: "StockCell", for: indexPath) as! StockCell
        cell.closeLabel.text = stockArray[indexPath.row].close
        cell.highLabel.text = stockArray[indexPath.row].high
        cell.lowLabel.text = stockArray[indexPath.row].low
        cell.openLabel.text = stockArray[indexPath.row].open
        cell.timeLabel.text = stockArray[indexPath.row].timeFormat(dateString: stockArray[indexPath.row].time)
        cell.volumeLabel.text = stockArray[indexPath.row].volume
        return cell
    }
    
    func stocksReceived(stocksArray: [StockModel]) {
        if stocksArray.count == 0 {
            DispatchQueue.main.async {
                UIAlertController.alert(title:"Oh", msg:"No data from server", target: self)
            }
            return
        }
        self.stockArray = stocksArray
        RuntimeStorage.stockArray = stocksArray
        
        DispatchQueue.main.async {
            self.stockTable.reloadData()
            self.rightBarButton.isEnabled = true
        }
    }
}
