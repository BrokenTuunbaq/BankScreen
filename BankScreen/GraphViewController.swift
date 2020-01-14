import UIKit
import SwiftCharts

class GraphViewController: UIViewController {

    let graphCompensationMultiplyer = 15.0
    override func viewDidLoad() {
        super.viewDidLoad()
        setBackgroundGraph(imageName: "graph-paper.png")
        graphDraw(pointsArray: buildGraphPointsArray())
    }
    
    func graphDraw(pointsArray: [(Double, Double)]) {
        let chartConfig = ChartConfigXY(
            xAxisConfig: ChartAxisConfig(from: 0, to: 100, by: 1),
            yAxisConfig: ChartAxisConfig(from: 0, to: 100, by: 1)
        )
        let frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height)

        let chart = LineChart(
            frame: frame,
            chartConfig: chartConfig,
            xTitle: "X axis",
            yTitle: "Y axis",
            lines: [
                (chartPoints: pointsArray, color: UIColor.blue),
                (chartPoints: [(Double, Double)](), color: UIColor.clear)
            ]
        )
        self.view.addSubview(chart.view)
    }
    
    func buildGraphPointsArray() -> [(Double, Double)] {
        
        var pointsArray = [(Double, Double)]()
        var xCounter: Double = 1.0
        for stock in RuntimeStorage.stockArray {
            pointsArray.append((xCounter, Double(stock.open)!))
            xCounter += 1
        }
        let minArray = pointsArray.min { $0.1 < $1.1 }
        
        var pointsMinMax = [(Double, Double)]()
        for point in pointsArray {
            pointsMinMax.append((point.0, graphCompensationMultiplyer*(point.1-minArray!.1)))
        }
        return pointsMinMax
    }
    
    func setBackgroundGraph(imageName: String) {
        let backgroundImageView = UIImageView(image: UIImage(named: imageName))
        backgroundImageView.frame = view.frame
        backgroundImageView.contentMode = .scaleAspectFill
        view.addSubview(backgroundImageView)
        view.sendSubviewToBack(backgroundImageView)
    }
}
