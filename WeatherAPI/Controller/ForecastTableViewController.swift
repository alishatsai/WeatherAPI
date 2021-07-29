//
//  ForecastTableViewController.swift
//  WeatherAPI
//
//  Created by Alisha on 2021/7/22.
//

import UIKit

class ForecastTableViewController: UITableViewController {
    
    var cityName: String?
    var forecastInfo: ForecastWeather?
    var forecastRow = [ForecastWeather.List]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchForecastDataFromCity(city: cityName!)
        print("Forecast Report Location: \(cityName!)")
    }

    func fetchForecastDataFromCity(city: String) {
        let urlstr = "https://api.openweathermap.org/data/2.5/\(API.forecast)?q=\(city)&appid=\(API.apiKey)&units=\(API.imperial)&lang=zh_tw"
        print(urlstr)
        if let url = URL(string: urlstr) {
            URLSession.shared.dataTask(with: url) { data, response, error in
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = .secondsSince1970
                if let data = data {
                    do {
                        let searchResponse = try decoder.decode(ForecastWeather.self, from: data)
                        self.forecastInfo = searchResponse
                        DispatchQueue.main.async {
                            self.forecastRow = (self.forecastInfo?.list)!
                            self.tableView.reloadData()
                        }
                    } catch {
                        print(error)
                    }
                }
            }.resume()
        }
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return forecastRow.count
    }
   
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "\(ForecastTableViewCell.self)", for: indexPath) as? ForecastTableViewCell else { return UITableViewCell() }
        //取消所選，animated選擇false會立刻執行取消動畫
        tableView.deselectRow(at: indexPath, animated: true)
        
        let forecastMain = forecastRow[indexPath.row].main
        let forecastWeather = forecastRow[indexPath.row].weather
        let forecastTime = forecastRow[indexPath.row].dt
//        let forcastDtText = forecastItem[indexPath.row].dtText
        
        cell.weatherImg.image = UIImage(named: forecastWeather[0].icon)
        cell.tempLabel.text = "🌡 \(tempFormate(f: forecastMain.temp))℃"
        cell.humidityLabel.text = "💧 " + String(forecastMain.humidity)
        cell.timeLabel.text = timeFormate(forecastTime)
        
        let suffix = forecastWeather[0].icon.suffix(1)
        if suffix == "n" {
            cell.backgroundColor = .black
            cell.tempLabel.textColor = .white
            cell.humidityLabel.textColor = .white
            cell.timeLabel.textColor = .white
        }
        if suffix == "d" {
            cell.backgroundColor = .white
            cell.tempLabel.textColor = .black
            cell.humidityLabel.textColor = .black
            cell.timeLabel.textColor = .black
        }
//        print("\(forcastDtText) \(forecastWeather[0].icon) ")
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tempFormate(f: Double) -> String {
        // 華氏轉換攝氏公式 ℃ = (℉-32)*5/9
        let c = (f - 32) * 5 / 9
        
        let tempString = String(format: "%.0f", c)
        return tempString
    }

    func timeFormate(_ date: Date?) -> String {
        guard let inputDate = date else { return "" }
        let formatter = DateFormatter()
        let timezone = forecastInfo?.city.timezone
        formatter.timeZone = TimeZone(secondsFromGMT: timezone!)
        formatter.dateFormat = "MM/dd E h:mm a"
        return formatter.string(from: inputDate)
    }
}

