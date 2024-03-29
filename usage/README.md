# Autopilot Scripts

This script gathers information to [submit via google forms][usage-report] as a usage report to the Conductor team.

[usage-report]: https://forms.gle/ioWC8JMcYMwGVeeb9

[Autopilot]: https://github.com/stride-nyc/stride-autopilot

## Usage Report

This script should be run from the project directory in your computer's terminal (outside of any Docker containers).

It will collect the following artifacts:
- project code
- project conductor configuration folder
- user conductor configuration folder

- If you want to include any changed project code in the report, it must be commited to the git repo first!

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/stride-nyc/autopilot-scripts/${AUTOPILOT_SCRIPTS_VERSION:-main}/usage/report.sh)"
```
