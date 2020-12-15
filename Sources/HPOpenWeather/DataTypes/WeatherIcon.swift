#if canImport(UIKit)
import UIKit
#elseif canImport(AppKit)
import AppKit
#endif
import SwiftUI
import Foundation

public enum WeatherIcon: String, Codable, CaseIterable {

    case clearSky = "01d"
	case clearSkyNight = "01n"
    case fewClouds = "02d"
	case fewCloudsNight = "02n"
	case scatteredClouds = "03d"
	case scatteredCloudsNight = "03n"
	case brokenClouds = "04d"
	case brokenCloudsNight = "04n"
	case showerRain = "09d"
	case showerRainNight = "09n"
	case rain = "10d"
	case rainNight = "10n"
	case thunderstorm = "11d"
	case thunderstormNight = "11n"
	case snow = "13d"
	case snowNight = "13n"
	case mist = "50d"
	case mistNight = "50n"

}

@available(OSX 11.0, iOS 13.0, watchOS 6.0, tvOS 13.0, *)
extension WeatherIcon {

	#if canImport(UIKit)

	public func filledUIImage(withConfiguration configuration: UIImage.Configuration? = nil) -> UIImage? {
		UIImage(systemName: makeIconName(filled: true), withConfiguration: configuration)
	}

	public func outlineUIImage(withConfiguration configuration: UIImage.Configuration? = nil) -> UIImage? {
		UIImage(systemName: makeIconName(filled: false), withConfiguration: configuration)
	}

	#elseif canImport(AppKit)

	public func filledNSImage(accessibilityDescription: String? = nil) -> NSImage? {
		NSImage(systemSymbolName: makeIconName(filled: true), accessibilityDescription: accessibilityDescription)
	}

	public func outlineNSImage(accessibilityDescription: String? = nil) -> NSImage? {
		NSImage(systemSymbolName: makeIconName(filled: false), accessibilityDescription: accessibilityDescription)
	}

	#endif

	public func filledImage() -> Image {
		Image(systemName: makeIconName(filled: true))
	}

	public func outlineImage() -> Image {
		Image(systemName: makeIconName(filled: false))
	}

	private func makeIconName(filled: Bool) -> String {
		let iconName: String
		switch self {
		case .clearSky:
			iconName = "sun.max"
		case .clearSkyNight:
			iconName = "moon"
		case .fewClouds:
			iconName = "cloud.sun"
		case .fewCloudsNight:
			iconName = "cloud.moon"
		case .scatteredClouds, .scatteredCloudsNight:
			iconName = "cloud"
		case .brokenClouds, .brokenCloudsNight:
			iconName = "smoke"
		case .showerRain, .showerRainNight:
			iconName = "cloud.rain"
		case .rain:
			iconName = "cloud.sun.rain"
		case .rainNight:
			iconName = "cloud.moon.rain"
		case .thunderstorm, .thunderstormNight:
			iconName = "cloud.bolt.rain"
		case .snow, .snowNight:
			return "snow"
		case .mist, .mistNight:
			iconName = "cloud.fog"
		}

		return iconName + (filled ? ".fill" : "")
	}

}
