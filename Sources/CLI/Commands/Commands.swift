
import Commander

/// a container type for commands of the applications
public enum Commands {

	public static var main = Group {
		$0.addCommand("init", Commands.initializeProject)
		$0.addCommand("issue", Group {
			$0.addCommand("create", Commands.createIssue)
			$0.addCommand("assign", Commands.assignIssue)
		})
		$0.addCommand("contributor", Group {
			$0.addCommand("add", Commands.addContributor)
		})
	}
}
