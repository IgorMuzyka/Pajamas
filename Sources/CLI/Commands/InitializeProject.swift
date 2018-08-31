
import Commander
import PajamasCore
import Rainbow

extension Commands {

	public static var initializeProject: CommandType {
		return command(
			Argument<String>("name", description: "Project name")
		) { name in
			do {
				try Project.default(name: name).initialize()
				print("Good luck with your new project: \(name)".green)
			} catch {
				print(error.colorized)
			}
		}
	}
}
