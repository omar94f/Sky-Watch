//
//  DayWeatherButton.swift
//  TheSky
//
//  Created by Omar Farooq on 9/15/21.
//

import UIKit

protocol DayWeatherButtonDelegate {
    func buttonSelected(button: DayWeatherButton)
}

class DayWeatherButton: UIControl {



    struct Constants {
        static let weatherViewSize: CGFloat = 30
        static let buttonWidth: CGFloat = 50
        static let buttonHeight: CGFloat = 100
    }


    let dayWeather: DayWeather
    var delegate: DayWeatherButtonDelegate?

    private lazy var dayLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.text = dayWeather.day.name
        label.textColor = isSelected ? .black : .gray
        label.font = .systemFont(ofSize: 12, weight: .regular)
        return label.preparedForAutolayout()
    }()

    private lazy var temperatureLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.text = "\(Int(dayWeather.temperatue).description)º"
        label.font = .systemFont(ofSize: 12, weight: .regular)
        label.textColor = isSelected ? .black : .gray
        return label.preparedForAutolayout()
    }()

    private lazy var weatherView: IconViewType = {
        let weatherView = dayWeather.weatherIcon.preparedForAutolayout()

        return weatherView
    }()

    private lazy var stackView: UIStackView = {
        let views: [UIView] = [dayLabel, weatherView, temperatureLabel]
        let stack = UIStackView(arrangedSubviews: views)
        stack.axis = .vertical
        stack.alignment = .fill
        stack.distribution = .fill
        stack.spacing = 8
        return stack.preparedForAutolayout()
    }()

    override var isSelected: Bool {
        willSet{
            if newValue != isSelected{
                if newValue {
                    didSelect()

                }
                else {
                    didUnSelect()
                }
            }
        }

    }

    init(frame: CGRect = .zero, weather: DayWeather) {
        dayWeather = weather
        super.init(frame: frame)

        setupView()
        setupGesture()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


    private func setupView() {
        addSubview(stackView)
        stackView.fillSuperview()
        
        layoutIfNeeded()
        layoutSubviews()
        
    }



    func setupWeatherView() {
        weatherView.setupViewAsIcon()
    }

    private func setupGesture() {
        addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTap)))
    }

    @objc private func handleTap() {
        if !isSelected {
            isSelected.toggle()
            delegate?.buttonSelected(button: self)
        }
    }

    private func didSelect() {
        weatherView.animateGrow()
        dayLabel.textColor = .black
        temperatureLabel.textColor = .black
        dayLabel.font = .systemFont(ofSize: 14, weight: .medium)
        temperatureLabel.font = .systemFont(ofSize: 14, weight: .medium)

    }

    private func didUnSelect() {
        weatherView.animateShrink()
        dayLabel.textColor = .gray
        temperatureLabel.textColor = .gray
        dayLabel.font = .systemFont(ofSize: 12, weight: .regular)
        temperatureLabel.font = .systemFont(ofSize: 12, weight: .regular)
    }

}
