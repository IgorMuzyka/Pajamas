
import Rainbow

extension Swift.Error {

	public var colorized: String {
        return self.localizedDescription.red
	}
}
