# obot-scripts
Shell scripts for working with [obot-controller](https://github.com/unhuman-io/obot-controller).

It can be handy to have command-line hooks to automate the build/push/check cycle. It is possible to do all of this automation in the IDE of one's choosing, these scripts may give hints on how to set that up.

* `motor_build.sh` - Does a standard build for the target defined in the environment variable `MOTOR_TARGET`.
* `motor_push.sh` - Pushes the build (parameters and program) over USB to the device for target defined in the environment variable `MOTOR_TARGET`.
* `motor_check.sh` - Phase-locks and applies current for an attached device.
* `motor_bench.sh` - Aggregates run-time statistics and logs them to a file for an attached device.
* `project_build.sh` - Builds a collection of configs that should represent the project.


# Installation

1. Clone the repo or copy the files to a location of your choosing.
2. Setup your `.bashrc` with the following aliases as appropriate:

```bash
export MOTOR_TARGET=motor_hall
alias mbuild="bash ~/obot-scripts/motor_build.sh"
alias mpush="bash ~/obot-scripts/motor_push.sh"

alias mbench="bash ~/obot-scripts/motor_benchmark.sh"
alias mcheck="bash ~/obot-scripts/motor_check.sh"
alias pbuild="bash ~/obot-scripts/project_build.sh"
```
