
import Commander
import PajamasCore

extension Commands {

	public static var createIssue: CommandType {
		return command(
			Argument<String>("description", description: "Issue description")
		) { description in
			do {
				let issue = Issue(description: description)
				try issue.persist(to: Issue.path)
				print("Created issue \(issue.index): \(issue.description)")
			} catch {
				print(error.colorized)
			}
		}
	}
}
