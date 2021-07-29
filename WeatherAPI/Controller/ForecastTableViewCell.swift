//
//  ForecastTableViewCell.swift
//  WeatherAPI
//
//  Created by Alisha on 2021/7/22.
//

import UIKit

class ForecastTableViewCell: UITableViewCell {

    @IBOutlet weak var weatherImg: UIImageView!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
