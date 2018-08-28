
import Commander
import FileKit

extension Commands {

	public static var initializeProject: CommandType {
		return command(
			Argument<String>("name", description: "Project name")
		) { name in
			do {
				try Project.default(name: name).initialize()
				print("Good luck with your new project: \(name)")
			} catch {
				print(error.colorized)
			}
		}
	}
}
