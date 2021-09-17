//
//  ViewController.swift
//  TheSky
//
//  Created by Omar Farooq on 9/14/21.
//

import UIKit

class ViewController: UIViewController {

    var currentWeather: WeatherEnum?

    private lazy var canvas: CanvasView = {
        let canvas = CanvasView()
        canvas.preparedForAutolayout()
        return canvas
    }()

    private lazy var weekView: WeekView = {

        let monWeather = DayWeather(day: .mon, weather: .sunny, temperatue: 34)
        let tueWeather = DayWeather(day: .tue, weather: .cloudy, temperatue: 24)
        let wedWeather = DayWeather(day: .wed, weather: .sunny, temperatue: 24)
        let thuWeather = DayWeather(day: .thu, weather: .sunny, temperatue: 24)
        let friWeather = DayWeather(day: .fri, weather: .sunny, temperatue: 24)
    
        let week = WeekView(frame: .zero,
                            dailyWeather: [monWeather, tueWeather, wedWeather, thuWeather, friWeather],
                            selectedDay: monWeather, actionHandler: .init {
                                [weak self] day in

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
    }
}

