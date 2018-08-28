
import Commander

extension Commands {

	public static var assignIssue: CommandType {
		return command(
			Argument<String>("contributor", description: "Contributor name or email")
		) { contributorNameOrEmail in
			print("Unimplemented".red)
		}
	}
}
