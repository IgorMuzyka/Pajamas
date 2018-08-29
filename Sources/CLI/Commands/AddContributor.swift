
import Commander
import SwiftShell
import PajamasCore

extension Commands {

	public static var addContributor: CommandType {
		return command(
			Option<String>("name", default: run(bash: "git config user.name").stdout),
			Option<String>("email", default: run(bash: "git config user.email").stdout)
		) { name, email in
			do {
				let contributor = Contributor(name: name, email: email)
				try contributor.persist(to: Contributor.path)
				print("Added contributor: \(contributor)")
			} catch {
				print(error.colorized)
			}

		}
	}
}
