import UIKit

class BankTableViewController: UITableViewController {

    var bankList = [BankModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bankList = ParseJson().parse(jsonString: JsonBank.jsonBankString)
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return bankList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BankCell", for: indexPath) as! BankCell
        cell.bankName.text = bankList[indexPath.row].name
        cell.bankSymbol.text = bankList[indexPath.row].stk
        cell.bankImage.setCustomImage(bankList[indexPath.row].img)

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        RuntimeStorage.bankSymbol = bankList[indexPath.row].stk
    }
}
