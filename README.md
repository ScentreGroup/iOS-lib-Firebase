## Installing

This project uses cocoapods-rome to build the Firebase.frameworks.

We then post-process the frameworks to split them out into iOS and simulator specific variants.

### Requirements
You may (or may not) need to ` gem install cocoapods-rome` the first time you run this project.

### Updating the firebase version.

Update the `Podfile` as usual and then execute `./install.sh`. This script will run `pod install` and then perform the thining.



