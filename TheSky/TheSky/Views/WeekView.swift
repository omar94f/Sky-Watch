//
//  WeekView.swift
//  TheSky
//
//  Created by Omar Farooq on 9/15/21.
//

import UIKit

class WeekView: UIView {

    struct WeekViewActionHandler {
        var daySelected: (DayWeather) -> Void
    }

    private let actionHandler: WeekViewActionHandler
    private let dailyWeather: [DayWeather]
    private(set) var selectedDay: DayWeather {
        didSet {
            actionHandler.daySelected(selectedDay)
        }
    }

    private var selectedButton: DayWeatherButton? {
        willSet {
            if let value = newValue, value != selectedButton {
                setupSelected(selected: value)
            } 
        }
    }
    private var buttons = [DayWeatherButton]()
    
    private lazy var stackView: UIStackView = {
        buttons = dailyWeather.map{
            let button = DayWeatherButton(frame: .zero, weather: $0)
            button.delegate = self

            return button  }
        let stackView = UIStackView(arrangedSubviews: buttons)
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.spacing = 8
        return stackView.preparedForAutolayout()
    }()

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    init(frame: CGRect = .zero,
         dailyWeather: [DayWeather],
         selectedDay: DayWeather,
         actionHandler: WeekViewActionHandler) {

        self.dailyWeather = dailyWeather
        self.selectedDay = selectedDay
        self.actionHandler = actionHandler
        super.init(frame: frame)

    }

    func setupLayout() {

        addSubview(stackView)
        stackView.fillSuperview(edgeInset: UIEdgeInsets(top: 12, left: 0, bottom: 0, right: 0))
        layoutIfNeeded()
        layoutSubviews()
        stackView.arrangedSubviews.forEach { view in
            (view as? DayWeatherButton)?.setupWeatherView()
        }
        buttons.forEach { (button) in
            if button.dayWeather.day == selectedDay.day {
                selectedButton = button
            }
        }
    }

    private func setupSelected(selected: DayWeatherButton) {
        if let button = selectedButton {
            button.isSelected = false
        }
        selected.isSelected = true
        selectedDay = selected.dayWeather
    }


}

extension WeekView: DayWeatherButtonDelegate {

    func buttonSelected(button: DayWeatherButton) {
        selectedButton = button
    }
}
