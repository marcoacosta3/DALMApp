//
//  NivelAlimentoViewController.swift
//  DALMApp
//
//  Created by Marco Acosta on 29/02/20.
//  Copyright © 2020 DALMApp. All rights reserved.
//

//Framework y librería
import UIKit
import Alamofire
import Charts

//Define la clase
class NivelAlimentoViewController: UIViewController {
    
    //Outlet de la gráfica
    @IBOutlet weak var foodLevelBarChartView: BarChartView!
    
    var levels: [Double] = []
    var labels: [String] = []
    //Variable usuario para token
    var usuario: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Llamado al método que obtiene los valores de la gráfica
        foodLevelRest(usuario: usuario, opcion: "2")
        print(usuario + " Nivel Alimento")
    }
    
    //Método para gráficar
    func setChart(dataPoints: [String], values: [Double]) {
        foodLevelBarChartView.noDataText = "No se han censado datos."
        var dataEntries: [BarChartDataEntry] = []
        for i in 0..<dataPoints.count {
            let dataEntry = BarChartDataEntry(x: Double(i), y: values[i])
            dataEntries.append(dataEntry)
        }
        //let chartDataSet:BarChartDataSet!
        let chartDataSet = BarChartDataSet(entries: dataEntries, label: "Niveles (%)")
        let chartData = BarChartData(dataSet: chartDataSet)
        foodLevelBarChartView.data = chartData
        foodLevelBarChartView.xAxis.valueFormatter = IndexAxisValueFormatter(values: dataPoints)
        foodLevelBarChartView.xAxis.granularityEnabled = true
        foodLevelBarChartView.xAxis.drawGridLinesEnabled = false
        foodLevelBarChartView.xAxis.labelPosition = .bottom
        foodLevelBarChartView.xAxis.labelCount = 2
        foodLevelBarChartView.xAxis.granularity = 1
        foodLevelBarChartView.leftAxis.enabled = true
        //barChartView.leftAxis.labelPosition = .outsideChart
        //barChartView.leftAxis.decimals = 0
        //_ = Double(values.min()!) - 0.1
        //contenedorBarChartView.leftAxis.axisMinimum = Double(values.min()! - 0.1)
        //barChartView.leftAxis.granularityEnabled = true
        //barChartView.leftAxis.granularity = 1.0
        //barChartView.leftAxis.labelCount = 5
        //contenedorBarChartView.leftAxis.axisMaximum = Double(values.max()! + 0.05)
        foodLevelBarChartView.data?.setDrawValues(true)
        foodLevelBarChartView.pinchZoomEnabled = true
        foodLevelBarChartView.scaleYEnabled = true
        foodLevelBarChartView.scaleXEnabled = true
        foodLevelBarChartView.highlighter = nil
        foodLevelBarChartView.doubleTapToZoomEnabled = true
        foodLevelBarChartView.chartDescription?.text = ""
        foodLevelBarChartView.rightAxis.enabled = false
        foodLevelBarChartView.animate(xAxisDuration: 2.0, yAxisDuration: 2.0, easingOption: .easeInOutQuart)
        chartDataSet.colors = [UIColor(red: 0/255, green: 76/255, blue: 153/255, alpha: 1)]
        foodLevelBarChartView.backgroundColor = UIColor(red: 189/255, green: 195/255, blue: 199/255, alpha: 1)
        //        let limitLine = ChartLimitLine(limit: 20.0)
        //        for i in 0..<values.count {
        //            let limit = values[i]
        //            if limit <= 5 {
        //                waterLevelBarChartView.leftAxis.addLimitLine(limitLine)
        //            }
        //        }
        
    }
    
    //Método para obtener los valores de la gráfica
    func foodLevelRest(usuario: String, opcion: String) {
        //URL del webservice a conectarse
        let url = "http://n-systems-mx.com/tta069/controlador/obtenerOperaciones.php"
        //Parámetros de la petición al webservice
        let parameters = ["token": usuario, "opcion": opcion]
        labels = ["Contenedor", "Plato"]
        //Headers de la petición al webservice
        let headers: HTTPHeaders = ["Content-Type": "application/x-www-form-urlencoded"]
        
        //Método de la petición al webservice, respuesta decodificada de tipo MonitoreoNivelAlimento
        AF.request(url, method: .post, parameters: parameters, headers: headers).validate().responseDecodable(of: MonitoreoNivelAlimento.self) { (response) in
            print(response.result)
            
            switch response.result {
            case .success(_):
                //Comprobar que haya plato
//                if response.value?.estado_plato2 == "Si" {
//                    //Llamado al método para gráficar
                    self.setChart(dataPoints: self.labels, values: [Double(response.value?.reserva_alimento ?? "")!, Double(response.value?.plato_alimento ?? "")!])
//
//                }else{
//                    self.displayAlertDishMissing()
//                    self.setChart(dataPoints: self.labels, values: [Double(response.value?.reserva_alimento ?? "")!, Double(response.value?.plato_alimento ?? "")!])
//                }
                break
            case .failure(_):
                self.displayAlertError()
                break
            }
        }
    }
    
    //Método de alerta de datos no censados
    func displayAlertError() {
        //Crea la alerta
        let alert = UIAlertController(title: "Error", message: "No se han censado datos.", preferredStyle: .alert)
        //Agrega la acción a la alerta
        alert.addAction(UIAlertAction(title: NSLocalizedString("Aceptar", comment: "Acción por defecto"), style: .default, handler: { _ in
            NSLog("El \"Aceptar\" ocurrio de alerta.")
        }))
        //Muestra la alerta
        self.present(alert, animated: true, completion: nil)
    }
    
    //Método de alerta de falta de plato
    func displayAlertDishMissing() {
        //Crea la alerta
        let alert = UIAlertController(title: "Plato Faltante", message: "El plato no esta en su lugar.", preferredStyle: .alert)
        //Agrega la acción a la alerta
        alert.addAction(UIAlertAction(title: NSLocalizedString("Aceptar", comment: "Acción por defecto"), style: .default, handler: { _ in
            NSLog("El \"Aceptar\" ocurrio de alerta.")
        }))
        //Muestra la alerta
        self.present(alert, animated: true, completion: nil)
    }
}
