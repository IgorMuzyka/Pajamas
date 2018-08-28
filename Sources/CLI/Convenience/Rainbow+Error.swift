
import Rainbow

extension Swift.Error {

	public var colorized: String {
		return String(describingErrorEnumCase: self).red
	}
}

extension String {

	fileprivate func capitalizingFirstLetter() -> String {
		return prefix(1).uppercased() + dropFirst()
	}
}

extension String {

	fileprivate init(describingErrorEnumCase error: Swift.Error) {
		var stops = [""]
		let words = "\(error)".split {
			let string = String($0)

			if string.lowercased() != string {
				stops.append(string)
				return true
			} else {
				return false
			}
		}

		self = zip(stops, words)
			.map(+)
			.joined(separator: " ")
			.capitalizingFirstLetter()
	}
}
