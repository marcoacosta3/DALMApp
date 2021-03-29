//
//  NivelAguaViewController.swift
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
class NivelAguaViewController: UIViewController {
    
    //Outlet de la gráfica
    @IBOutlet weak var waterLevelBarChartView: BarChartView!
    
    //Variable usuario para token
    var usuario: String = ""
    var levels: [Double] = []
    var labels: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(usuario + " Nivel Agua")
        //Llamado al método que obtiene los valores de la gráfica
        waterLevelRest(usuario: usuario, opcion: "1")
        
    }
    
    //Método para gráficar
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
    
    //Método para obtener los valores de la gráfica
    func waterLevelRest(usuario: String, opcion: String) {
        //URL del webservice a conectarse
        let url = "http://n-systems-mx.com/tta069/controlador/obtenerOperaciones.php"
        //Parámetros de la petición al webservice
        let parameters = ["token": usuario, "opcion": opcion]
        labels = ["Contenedor", "Plato"]
        //Headers de la petición al webservice
        let headers: HTTPHeaders = ["Content-Type": "application/x-www-form-urlencoded"]
        
        //Método de la petición al webservice, respuesta decodificada de tipo MonitoreoNivelAgua
        AF.request(url, method: .post, parameters: parameters, headers: headers).validate().responseDecodable(of: MonitoreoNivelAgua.self) { (response) in
            print(response.result)
            
            //Llamado al método para gráficar
//            self.setChart(dataPoints: self.labels, values: [Double(response.value?.reserva_agua ?? "")!, Double(response.value?.plato_agua ?? "")!])
            switch response.result {
            case .success(_):
                //Comprobar que haya plato
//                if response.value?.estado_plato1 == "Si" {
//                    //Llamado al método para gráficar
                    self.setChart(dataPoints: self.labels, values: [Double(response.value?.reserva_agua ?? "")!, Double(response.value?.plato_agua ?? "")!])
//
//                }else{
//                    self.displayAlertDishMissing()
//                    self.setChart(dataPoints: self.labels, values: [Double(response.value?.reserva_agua ?? "")!, Double(response.value?.plato_agua ?? "")!])
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
