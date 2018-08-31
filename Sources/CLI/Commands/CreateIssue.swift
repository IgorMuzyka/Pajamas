
import Commander
import PajamasCore
import Rainbow

private enum IssueCreationError: Error {

	case projectBoardHasNoSuchTable(Table)
}

extension Commands {

	public static var createIssue: CommandType {
		return command(
			Argument<String>("description", description: "Issue description"),
			Option<String>("table", default: Table.backlog.name)
		) { description, table in
			do {
				let project = try Project.current()
				let table = Table(name: table)

				guard project.board.has(table) else {
					throw IssueCreationError.projectBoardHasNoSuchTable(table)
				}

				let issue = Issue(description: description, table: table)
				try issue.save()
				print("Created issue \(issue.identifier): \(issue.description) \(issue.table)".green)
			} catch {
				print(error.colorized)
			}
		}
	}
}
