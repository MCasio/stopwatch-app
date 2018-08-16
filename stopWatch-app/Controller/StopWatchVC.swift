//
//  ViewController.swift
//  stopWatch-app
//
//  Created by Mahmoud Mohammed on 8/14/18.
//  Copyright © 2018 Mahmoud Mohammed. All rights reserved.
//

import UIKit

class StopWatchVC: UIViewController, UITableViewDelegate {

    // MARK: - Variables
    private let mainStopWatch: Stopwatch = Stopwatch()
    private let lapStopWtch: Stopwatch = Stopwatch()
    private var laps: [String] = []
    private var isPlay: Bool = false

    
    // MARK: - UI Components
    @IBOutlet weak var timerLbl: UILabel!
    @IBOutlet weak var lapTimerLbl: UILabel!
    @IBOutlet weak var lapResetBtn: UIButton!
    @IBOutlet weak var starPauseBtn: UIButton!
    @IBOutlet weak var lapsTableView: UITableView!
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        lapsTableView.delegate = self
        lapsTableView.dataSource = self
    }

    // MARK: - Actions
    
    @IBAction func startPauseBtnWasPressed(_ sender: Any) {
        lapResetBtn.isEnabled = true
        
        if !isPlay {
            changeButton(lapResetBtn, title: "Lap", titleColor: #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), btnBackGroundColor: #colorLiteral(red: 0.4922404289, green: 0.7722371817, blue: 0.4631441236, alpha: 1))
            changeButton(starPauseBtn, title: "Stop", titleColor: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), btnBackGroundColor: #colorLiteral(red: 0.4922404289, green: 0.7722371817, blue: 0.4631441236, alpha: 1))
            
            mainStopWatch.timer = Timer.scheduledTimer(timeInterval: 0.035, target: self, selector: #selector(StopWatchVC.updateMainTimer), userInfo: nil, repeats: true)
            lapStopWtch.timer = Timer.scheduledTimer(timeInterval: 0.035, target: self, selector: #selector(StopWatchVC.updateLapTimer), userInfo: nil, repeats: true)
            
            isPlay = true
        } else {
            changeButton(starPauseBtn, title: "Start", titleColor: #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), btnBackGroundColor: #colorLiteral(red: 0.4922404289, green: 0.7722371817, blue: 0.4631441236, alpha: 1))
            changeButton(lapResetBtn, title: "Reset", titleColor: #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), btnBackGroundColor: #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1))
            
            mainStopWatch.timer.invalidate()
            lapStopWtch.timer.invalidate()
            
            isPlay = false
            
        }
        
    }
    
    @IBAction func lapResetBtnWasPressed(_ sender: Any) {
        if lapResetBtn.titleLabel?.text == "Lap" {
            let currentTimer = lapTimerLbl.text
            laps.append(currentTimer!)
            resetLapTimer()
            lapStopWtch.timer = Timer.scheduledTimer(timeInterval: 0.035, target: self, selector: #selector(StopWatchVC.updateLapTimer), userInfo: nil, repeats: true)
            lapsTableView.reloadData()
        } else if lapResetBtn.titleLabel?.text == "Reset" {
            lapResetBtn.isEnabled = false
            changeButton(lapResetBtn, title: "Lap", titleColor: #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), btnBackGroundColor: #colorLiteral(red: 0.7464011312, green: 0.8857318759, blue: 0.7402122021, alpha: 1))
            
            resetLapTimer()
            resetMainTimer()
            
            lapsTableView.reloadData()
        }
    }
    
    // MARK - Private Helpers
    
    private func changeButton(_ button: UIButton, title: String, titleColor: UIColor, btnBackGroundColor: UIColor) {
        button.setTitle(title, for: UIControlState())
        button.setTitleColor(titleColor, for: UIControlState())
        button.backgroundColor = btnBackGroundColor
    }
    
    private func resetLapTimer() {
        resetTimer(lapStopWtch, label: lapTimerLbl)
    }
    
    private func resetMainTimer() {
        resetTimer(mainStopWatch, label: timerLbl)
        laps.removeAll()
        lapsTableView.reloadData()
    }
    
    private func resetTimer(_ stopwatch: Stopwatch, label: UILabel) {
        stopwatch.timer.invalidate()
        stopwatch.counter = 0.0
        label.text = "00:00:00"
    }
    
    @objc func updateMainTimer() {
        updateTimer(mainStopWatch, label: timerLbl)
    }
    
    @objc func updateLapTimer(){
        updateTimer(lapStopWtch, label: lapTimerLbl)
    }
    
    func updateTimer(_ stopwatch: Stopwatch, label: UILabel) {
        stopwatch.counter += 0.035
        
        var minutes: String = "\((Int)(stopwatch.counter / 60))"
        if (Int)(stopwatch.counter / 60) < 10 {
            minutes = "0\(minutes)"
        }
        
        var seconds: String = String(format: "%.2f", (stopwatch.counter.truncatingRemainder(dividingBy: 60)))
        if stopwatch.counter.truncatingRemainder(dividingBy: 60) < 10 {
            seconds = "0" + seconds
        }
        label.text = minutes + ":" + seconds
    }
}

    // MARK: - Extensions

extension StopWatchVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return laps.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = lapsTableView.dequeueReusableCell(withIdentifier: "lapCell") as? LapCell else { return UITableViewCell() }
        cell.configureCell(atIndexPath: indexPath, lapArray: laps)
        if indexPath.row % 2 == 0 {
            cell.backgroundColor = #colorLiteral(red: 0.7164870807, green: 1, blue: 0.5910180075, alpha: 0.1009573064)
        } else {
            cell.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        }
        return cell
    }
    
    
}

