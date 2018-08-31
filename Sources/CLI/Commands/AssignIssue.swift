
import Commander
import PajamasCore
import Rainbow

private enum IssueAssignationError: Error {

	case failedToFindContributor(by: String)
	case failedToFindIssueWith(identifier: String)
}

extension Commands {

	public static var assignIssue: CommandType {
		let me = "me"

		return command(
			Argument<String>("issue", description: "Issue identifier"),
			Option<String>("to", default: me)
		) { issueIdentifier, nameOrEmail in
			do {
				guard let contributor: Contributor = (nameOrEmail == me) ? .current : try .find(by: nameOrEmail) else {
					throw IssueAssignationError.failedToFindContributor(by: nameOrEmail)
				}

				guard var issue = try Issue.find(by: issueIdentifier) else {
					throw IssueAssignationError.failedToFindIssueWith(identifier: issueIdentifier)
				}

				issue.asignee = contributor
				try issue.save()

				print("Assigned contributor: \(contributor) to issue: \(issue.identifier), \(issue.description)".green)
			} catch {
				print(error.colorized)
			}
		}
	}
}
