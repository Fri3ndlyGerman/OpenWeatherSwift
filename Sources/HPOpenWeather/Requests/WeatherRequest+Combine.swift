#if canImport(Combine)
import Combine
import Foundation

@available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
public extension WeatherRequest {

	func publisher(apiKey: String, language: RequestLanguage = .english, units: RequestUnits = .metric) -> AnyPublisher<Output, Error> {
		let settings = OpenWeather.Settings(apiKey: apiKey, language: language, units: units)
		return publisher(settings: settings)
	}

	func publisher(settings: OpenWeather.Settings) -> AnyPublisher<Output, Error> {
		let request = APINetworkRequest<Output>(url: makeURL(settings: settings), urlSession: urlSession, finishingQueue: finishingQueue)
		return request.dataTaskPublisher()
	}

	static func error(from response: URLResponse?) -> Error? {
		guard let response = response as? HTTPURLResponse else {
			return nil
		}

		switch response.statusCode {
		case 200...299:
			return nil
		default:
			let errorCode = URLError.Code(rawValue: response.statusCode)
			return URLError(errorCode)
		}
	}

}

#endif
