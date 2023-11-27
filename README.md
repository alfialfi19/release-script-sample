# Release Script Sample App

A new Flutter project just for dummy example app for demo `release_scrip.sh`.

## Release Script

In Expense Management, usually we create a `release branch` and `release tag` manually.
For example, we want to release `example-1.5.0`. Before creating a `release tag`, we must checkout
a new branch called `release/example-1.5` from `TRUNK_BRANCH`, and then bump the version
from that branch, and then finally can create a new tag `example-1.5.0`.
Sometimes, it too takes time.

So, we already have the `release_script.sh` file to automate the release process.
Things need to do just run it with `sh release_script.sh`, and then follow the instruction.

There are 2 main things that can be done from the script. The first is creating a tag with a
new branch, second is creating a tag from the existing branch. The second option will be
needed if we do a patch version.

### Create a new branch option

1. After running the script, press 'c', and then enter.
2. Input new branch name (i.e. `release/example-1.5`).
3. Wait until the process finishes, and then input the
   version that want to release (i.e. `1.5.0`). This already changes the version
   in `pubspec.yaml` file too.
4. And then creating the tagging process already done, you can manually cherry-pick
   or pull it changes to the `TRUNK_BRANCH`.


### Update and existing branch option

1. After running the script, press 'u', and then enter.
2. Input existing branch name (i.e. `release/example-1.5`).
3. Wait until the process finishes, and then input the
   version that want to release (i.e. `1.5.1`). This already changes the version
   in `pubspec.yaml` file too.
4. And then creating the tagging process already done, you can manually cherry-pick
   or pull it changes to the `TRUNK_BRANCH`.


If you input the wrong command, or the branch already exists, there will be error message appear.
And the shell script will be stopped.

- - -