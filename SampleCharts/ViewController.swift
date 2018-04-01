//
//  ViewController.swift
//  SampleCharts
//
//  Created by Franklin S D'souza on 30/03/18.
//  Copyright © 2018 Zeeyad. All rights reserved.
//

import UIKit
import Charts

class ViewController: UIViewController {
    
    @IBOutlet weak var lineChartView: LineChartView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupChartXAxis()
        setupChartYAxis()
        updateGraph()
        lineChartView.animate(yAxisDuration: 3)

        for set in lineChartView.data!.dataSets as! [LineChartDataSet] {
            set.drawFilledEnabled = !set.drawFilledEnabled
            set.lineWidth = 2
        }
        lineChartView.setNeedsDisplay()
    }
    
    func setupChartXAxis() {
        lineChartView.xAxis.valueFormatter = WeekNameFormatter()
        lineChartView.xAxis.labelPosition = .bottom
        lineChartView.xAxis.drawGridLinesEnabled = false
    }
    
    func setupChartYAxis() {
        setupChartLeftAxis()
        setupChartRightAxis()
    }
    
    func setupChartLeftAxis() {
        lineChartView.leftAxis.drawAxisLineEnabled = false
        lineChartView.leftAxis.drawGridLinesEnabled = false
        lineChartView.leftAxis.axisMaximum = 80
        lineChartView.leftAxis.axisMinimum = 0
    }
    
    func setupChartRightAxis() {
        lineChartView.rightAxis.drawAxisLineEnabled = false
        lineChartView.rightAxis.drawLabelsEnabled = false
        lineChartView.rightAxis.drawGridLinesEnabled = false
    }
    
    func updateGraph() {
        var numbers = [7.5, 3.5, 9, 11, 18.5, 8, 3]
        var lineChartEntry = [ChartDataEntry]()
        
        for i in 0..<numbers.count {
            let datEntry = ChartDataEntry(x: Double(i), y: numbers[i])
            
            lineChartEntry.append(datEntry)
        }
        
        let chartDataSet = LineChartDataSet(values: lineChartEntry, label: "Chart")
        chartDataSet.drawCirclesEnabled = false
        chartDataSet.mode = .horizontalBezier
        let lineColor = UIColor(red: 29/255, green: 199/255, blue: 182/255, alpha: 1.0)
    
        chartDataSet.colors = [lineColor]
        
        let chartData = LineChartData()
        chartData.addDataSet(chartDataSet)
        
        lineChartView.data = chartData
        lineChartView.chartDescription?.text = "New chart"
        
    }
 
    

}

final class WeekNameFormatter: NSObject, IAxisValueFormatter {
    func stringForValue(_ value: Double, axis: AxisBase?) -> String {
        let dayNum = (Int(value) == 6) ? 0 : Int(value) + 1
        return Calendar.current.shortWeekdaySymbols[dayNum]
    }
}





final class MonthNameFormater: NSObject, IAxisValueFormatter {
    func stringForValue( _ value: Double, axis _: AxisBase?) -> String {
        return Calendar.current.shortMonthSymbols[Int(value)]
    }
}

