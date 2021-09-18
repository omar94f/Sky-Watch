//
//  ViewController.swift
//  TheSky
//
//  Created by Omar Farooq on 9/14/21.
//

import UIKit

class ViewController: UIViewController {

    var currentWeather: WeatherEnum?

    private lazy var dayLabel: UILabel = {
        let frame = CGRect(x: 20, y: view.bounds.quarterHeight - 50, width: 120, height: 50)
        let label = UILabel(frame: frame)
        label.textColor = .white
        label.font = .systemFont(ofSize: 34, weight: .medium)
        return label
    }()

    private lazy var temperatureLabel: UILabel = {
        let frame = CGRect(x: 20, y: view.bounds.quarterHeight, width: 120, height: 50)
        let label = UILabel(frame: frame)
        label.textColor = .white
        label.font = .systemFont(ofSize: 32, weight: .regular)
        return label
    }()

    private lazy var canvas: CanvasView = {
        let canvas = CanvasView()
        canvas.preparedForAutolayout()
        return canvas
    }()

    private lazy var weekView: WeekView = {

        let monWeather = DayWeather(day: .mon, weather: .cloudy, temperatue: 24)
        let tueWeather = DayWeather(day: .tue, weather: .sunny, temperatue: 34)
        let wedWeather = DayWeather(day: .wed, weather: .snowy, temperatue: 2)
        let thuWeather = DayWeather(day: .thu, weather: .cloudy, temperatue: 26)
        let friWeather = DayWeather(day: .fri, weather: .rainy, temperatue: 16)
    
        let week = WeekView(frame: .zero,
                            dailyWeather: [monWeather, tueWeather, wedWeather, thuWeather, friWeather],
                            selectedDay: monWeather, actionHandler: .init {
                                [weak self] day in
                                self?.temperatureLabel.text = "\(Int(day.temperatue))º"
                                self?.dayLabel.text = day.day.name
                                guard let self = self, self.currentWeather != day.weather else { return }
                                let canvasAnimation = CanvasAnimationFactory.getAnimation(for: day.weather, frame: self.canvas.bounds)
                                self.canvas.addCanvasAnimation(animation: canvasAnimation)
                                self.currentWeather = day.weather

                            })
        week.backgroundColor = .white
        return week.preparedForAutolayout()
    }()

    private lazy var stackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [canvas, weekView])

        stack.axis = .vertical
        stack.alignment = .fill
        stack.distribution = .fill
        stack.spacing = 8
        return stack.preparedForAutolayout()
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        setup()
    }

    override var preferredStatusBarStyle: UIStatusBarStyle {
        .lightContent
    }

    func setup() {

        
        view.backgroundColor = .white
        view.addSubview(stackView)
        NSLayoutConstraint.activate([
            weekView.heightAnchor.constraint(equalToConstant: 150)
        ])
        stackView.fillSuperview()
        stackView.layoutIfNeeded()
        stackView.layoutSubviews()
        canvas.setupLayout()
        weekView.setupLayout()
        view.addSubview(temperatureLabel)
        view.addSubview(dayLabel)
    }
}

