
import Commander

extension Commands {

	public static var addContributor: CommandType {
		return command(
			Argument<String>("name", description: "Contributor name"),
			Argument<String>("email", description: "Contributor email")
		) { name, email in
			print("Unimplemented".red)
		}
	}
}
