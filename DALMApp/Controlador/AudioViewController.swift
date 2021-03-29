//
//  AudioViewController.swift
//  DALMApp
//
//  Created by Marco Acosta on 29/02/20.
//  Copyright © 2020 DALMApp. All rights reserved.
//

//Framework y librería
import UIKit
import AVFoundation
import Alamofire

//Define la clase y los protocolos de audio
class AudioViewController: UIViewController, AVAudioPlayerDelegate, AVAudioRecorderDelegate {
    
    //Outlets de los textfield, picker, label, botones
    @IBOutlet weak var recordButton: UIButton!
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var recordingTimeLabel: UILabel!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var mainMenuButton: UIButton!
    
    var audioRecorder: AVAudioRecorder!
    var audioPlayer: AVAudioPlayer!
    var meterTimer: Timer!
    var isAudioRecordingGranted: Bool!
    var isRecording = false
    var isPlaying = false
    
    //Variable usuario para token
    var usuario: String = ""
    
    //Método que mostrará el navigationbar
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
    }
    
    //Método que desaparecerá el navigationbar
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.isNavigationBarHidden = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Llamado a método de permiso de grabación
        checkRecordPermission()
        //Diseño de botones
        recordButton.layer.cornerRadius = recordButton.frame.size.height / 5
        playButton.layer.cornerRadius = playButton.frame.size.height / 5
        saveButton.layer.cornerRadius = saveButton.frame.size.height / 3
        mainMenuButton.layer.cornerRadius = mainMenuButton.frame.size.height / 3
        print(usuario + " Audio")
    }
    
    //Método que revisa el permiso de grabación
    func checkRecordPermission()
    {
        switch AVAudioSession.sharedInstance().recordPermission {
        case AVAudioSessionRecordPermission.granted:
            isAudioRecordingGranted = true
            break
        case AVAudioSessionRecordPermission.denied:
            isAudioRecordingGranted = false
            break
        case AVAudioSessionRecordPermission.undetermined:
            AVAudioSession.sharedInstance().requestRecordPermission({ (allowed) in
                if allowed {
                    self.isAudioRecordingGranted = true
                } else {
                    self.isAudioRecordingGranted = false
                }
            })
            break
        default:
            break
        }
    }
    
    //Método de la ruta de almacenamiento
    func getDocumentsDirectory() -> URL
    {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentsDirectory = paths[0]
        return documentsDirectory
    }
    
    //Método de la ruta del archivo de audio
    func getFileUrl() -> URL
    {
        let filename = "myRecording.m4a"
        let filePath = getDocumentsDirectory().appendingPathComponent(filename)
        return filePath
    }
    
    //Método para preparar la grabación (específicaciones del archivo de audio)
    func setupRecorder()
    {
        if isAudioRecordingGranted
        {
            let session = AVAudioSession.sharedInstance()
            do
            {
                try session.setCategory(AVAudioSession.Category.playAndRecord, options: AVAudioSession.CategoryOptions.defaultToSpeaker)
                try session.setActive(true)
                let settings = [
                    AVFormatIDKey: Int(kAudioFormatMPEG4AAC),
                    AVSampleRateKey: 44100,
                    AVNumberOfChannelsKey: 2,
                    AVEncoderAudioQualityKey:AVAudioQuality.high.rawValue
                ]
                audioRecorder = try AVAudioRecorder(url: getFileUrl(), settings: settings)
                audioRecorder.delegate = self
                audioRecorder.isMeteringEnabled = true
                audioRecorder.prepareToRecord()
            }
            catch let error {
                displayAlert(msgTitle: "Error", msgDescription: error.localizedDescription, actionTitle: "OK")
            }
        }
        else
        {
            displayAlert(msgTitle: "Error", msgDescription: "No tienes acceso a tu microfono.", actionTitle: "OK")
        }
    }
    
    //Método de la alerta
    func displayAlert(msgTitle : String , msgDescription : String ,actionTitle : String)
    {
        let ac = UIAlertController(title: msgTitle, message: msgDescription, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: actionTitle, style: .default)
        {
            (result : UIAlertAction) -> Void in
            _ = self.navigationController?.popViewController(animated: true)
        })
        present(ac, animated: true)
    }
    
    //Action del botón grabar
    @IBAction func startRecordingButtonPressed(_ sender: UIButton) {
        
        if(isRecording)
        {
            finishAudioRecording(success: true)
            recordButton.setTitle("Grabar", for: .normal)
            playButton.isEnabled = true
            isRecording = false
        }
        else
        {
            setupRecorder()
            audioRecorder.record() //forDuration: 10.0
            meterTimer = Timer.scheduledTimer(timeInterval: 0.1, target:self, selector:#selector(self.updateAudioMeter(timer:)), userInfo:nil, repeats:true)
            recordButton.setTitle("Detener", for: .normal)
            playButton.isEnabled = false
            isRecording = true
        }
    }
    
    //Método del timer
    @objc func updateAudioMeter(timer: Timer)
    {
        if audioRecorder.isRecording
        {
            let hr = Int((audioRecorder.currentTime / 60) / 60)
            let min = Int(audioRecorder.currentTime / 60)
            let sec = Int(audioRecorder.currentTime.truncatingRemainder(dividingBy: 60))
            let totalTimeString = String(format: "%02d:%02d:%02d", hr, min, sec)
            recordingTimeLabel.text = totalTimeString
            audioRecorder.updateMeters()
        }
    }
    
    //Método para terminar de grabar
    func finishAudioRecording(success: Bool)
    {
        if success
        {
            audioRecorder.stop()
            audioRecorder = nil
            meterTimer.invalidate()
            print("Grabado exitosamente.")
        }
        else
        {
            displayAlert(msgTitle: "Error", msgDescription: "Grabación fallida.", actionTitle: "OK")
        }
    }
    
    //Método para preparaar la reproducción del audio
    func preparePlay()
    {
        do
        {
            audioPlayer = try AVAudioPlayer(contentsOf: getFileUrl())
            audioPlayer.delegate = self
            audioPlayer.prepareToPlay()
        }
        catch{
            print("Error")
        }
    }
    
    //Action del botón reproducir
    @IBAction func playRecordingButtonPressed(_ sender: UIButton) {
        if(isPlaying)
        {
            audioPlayer.stop()
            recordButton.isEnabled = true
            //playButton.setTitle("Reproducir", for: .normal)
            playButton.setImage(UIImage(named: "playButton.png"), for: .normal)
            isPlaying = false
        }
        else
        {
            if FileManager.default.fileExists(atPath: getFileUrl().path)
            {
                recordButton.isEnabled = false
                //playButton.setTitle("Pausa", for: .normal)
                playButton.setImage(UIImage(named: "pauseButton.png"), for: .normal)
                preparePlay()
                audioPlayer.play()
                isPlaying = true
            }
            else
            {
                displayAlert(msgTitle: "Error", msgDescription: "Archivo de audio faltante.", actionTitle: "OK")
            }
        }
    }
    
    //Método para habilitar el botón de reproducir
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool)
    {
        if !flag
        {
            finishAudioRecording(success: false)
        }
        playButton.isEnabled = true
    }
    
    //Método para habilitar botón de grabar
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool)
    {
        recordButton.isEnabled = true
    }
    
    //Método de alerta de guardado
    func displayAlertSaved() {
        let alert = UIAlertController(title: "Configuración Guardada", message: "La configuración se ha guardado exitosamente.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("Aceptar", comment: "Acción por defecto"), style: .default, handler: { _ in
            NSLog("La \"Aceptar\" ocurrio de alerta.")
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    //Action del botón guardar
    @IBAction func didTapSaveButon(_ sender: UIButton) {
        displayAlertSaved()
    }
    
    //Método para preparar segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let identifier = segue.identifier, identifier == "MenuPrincipalButtonToMenuPrincipal" {
            guard let menuPrincipalBVC = segue.destination as? MenuPrincipalViewController else {
                return
            }
            menuPrincipalBVC.usuario = self.usuario
        }
    }
    
}
