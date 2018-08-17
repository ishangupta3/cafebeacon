//
//  ChartsViewController.swift
//  IndoorInBackground
//
//  Created by ishgupta on 7/30/18.
//  Copyright © 2018 Estimote Inc. All rights reserved.
//

import UIKit
import Charts

class ChartsViewController: UIViewController {

    @IBOutlet weak var lineChart: LineChartView!
    
    
    // https://www.appcoda.com/ios-charts-api-tutorial/
    override func viewDidLoad() {
        super.viewDidLoad()

        setupChart()
        
        
    }
    
    
    func setupChart() {
        var lineChartEntry = [ChartDataEntry]()
        let x = [1,2,3,4,5]
        for time in 0..<x.count {
            let value = ChartDataEntry(x: Double(time), y: Double(x[time]))
            lineChartEntry.append(value)
        }
        
        let values = ["Mon","Tues", "Wed", "Thurs", "Fri"]
        
        let line1 = LineChartDataSet(values: lineChartEntry, label: "Waiting Time")
        line1.colors = ChartColorTemplates.joyful()
        
        let limit = ChartLimitLine(limit: 4, label: "Goal")
        //let limit2 = ChartLimitLine(limit: 13, label: "Current Waiting Time")
        
        lineChart.rightAxis.addLimitLine(limit)
       // lineChart.rightAxis.addLimitLine(limit2)
        let data = LineChartData()
        data.addDataSet(line1)
        lineChart.animate(xAxisDuration: 2.0, yAxisDuration: 2.0, easingOption: .easeInBounce)
        lineChart.data = data
        lineChart.backgroundColor =   UIColor(red: 189/255, green: 195/255, blue: 199/255, alpha: 1)
        
        lineChart.chartDescription?.text = "Cafe Waiting Times"
    
        
    }
    
    
}

