//
//  NivelAguaViewController.swift
//  DALMApp
//
//  Created by Marco Acosta on 29/05/20.
//  Copyright © 2020 DALMApp. All rights reserved.
//

import UIKit
import Alamofire
import Charts

class NivelAguaViewController: UIViewController {

    @IBOutlet weak var waterLevelBarChartView: BarChartView!
    
    var usuario: String = ""
    var levels: [Double] = []
    var labels: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        print(usuario + " Nivel Agua")
        
        waterLevelRest(usuario: usuario, opcion: "1")

    }
    
    func setChart(dataPoints: [String], values: [Double]) {
            waterLevelBarChartView.noDataText = "No se han censado datos."
            var dataEntries: [BarChartDataEntry] = []
            for i in 0..<dataPoints.count {
                let dataEntry = BarChartDataEntry(x: Double(i), y: values[i])
                dataEntries.append(dataEntry)
            }
            //let chartDataSet:BarChartDataSet!
            let chartDataSet = BarChartDataSet(entries: dataEntries, label: "Niveles (%)")
            let chartData = BarChartData(dataSet: chartDataSet)
            waterLevelBarChartView.data = chartData
            waterLevelBarChartView.xAxis.valueFormatter = IndexAxisValueFormatter(values: dataPoints)
            waterLevelBarChartView.xAxis.granularityEnabled = true
            waterLevelBarChartView.xAxis.drawGridLinesEnabled = false
            waterLevelBarChartView.xAxis.labelPosition = .bottom
            waterLevelBarChartView.xAxis.labelCount = 2
            waterLevelBarChartView.xAxis.granularity = 1
            waterLevelBarChartView.leftAxis.enabled = true
            //barChartView.leftAxis.labelPosition = .outsideChart
            //barChartView.leftAxis.decimals = 0
            //_ = Double(values.min()!) - 0.1
            //contenedorBarChartView.leftAxis.axisMinimum = Double(values.min()! - 0.1)
            //barChartView.leftAxis.granularityEnabled = true
            //barChartView.leftAxis.granularity = 1.0
            //barChartView.leftAxis.labelCount = 5
            //contenedorBarChartView.leftAxis.axisMaximum = Double(values.max()! + 0.05)
            waterLevelBarChartView.data?.setDrawValues(true)
            waterLevelBarChartView.pinchZoomEnabled = true
            waterLevelBarChartView.scaleYEnabled = true
            waterLevelBarChartView.scaleXEnabled = true
            waterLevelBarChartView.highlighter = nil
            waterLevelBarChartView.doubleTapToZoomEnabled = true
            waterLevelBarChartView.chartDescription?.text = ""
            waterLevelBarChartView.rightAxis.enabled = false
            waterLevelBarChartView.animate(xAxisDuration: 2.0, yAxisDuration: 2.0, easingOption: .easeInOutQuart)
            chartDataSet.colors = [UIColor(red: 0/255, green: 76/255, blue: 153/255, alpha: 1)]
            waterLevelBarChartView.backgroundColor = UIColor(red: 189/255, green: 195/255, blue: 199/255, alpha: 1)
    //        let limitLine = ChartLimitLine(limit: 20.0)
    //        for i in 0..<values.count {
    //            let limit = values[i]
    //            if limit <= 5 {
    //                waterLevelBarChartView.leftAxis.addLimitLine(limitLine)
    //            }
    //        }
            
        }
        
        
        func waterLevelRest(usuario: String, opcion: String) {
            let url = "http://n-systems-mx.com/tta069/controlador/obtenerOperaciones.php"
            let parameters = ["token": usuario, "opcion": opcion]
            labels = ["Plato", "Contenedor"]
            let headers: HTTPHeaders = ["Content-Type": "application/x-www-form-urlencoded"]

            AF.request(url, method: .post, parameters: parameters, headers: headers).validate().responseDecodable(of: MonitoreoNivelAgua.self) { (response) in
                print(response.result)
                
                self.setChart(dataPoints: self.labels, values: [Double(response.value?.reserva_agua ?? "")!, Double(response.value?.plato_agua ?? "")!])
            }
        }

}
