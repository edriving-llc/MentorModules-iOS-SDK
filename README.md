# MentorModules #

### Installation with CocoaPods ###

#### Podfile

To integrate MentorModules into your Xcode project using CocoaPods, specify it in your `Podfile`:

```ruby
target 'TargetName' do
pod 'MentorModules'
end
```

Then, run the following command:

```bash
$ pod install
```

### Usage ###

#### Swift

```swift
import MentorModules
```

```swift
let modules = MRModules()
modules.initSDK(apiKey: <API_KEY>, clientUserId: <USER_ID>) { (user, error) in
            ...

            modules.getModules() { [weak self] (modules, error) in
            	...
            }
        }
```

#### Objective-C

```objc
#import "MentorModules-Swift.h"
```

```objc
MRModules *modules = [MRModules new];
[modules initSDKWithApiKey:<API_KEY> clientUserId:<USER_ID> completion:^(MRUser *user, NSError *error) {
	...
	[modules getModulesWithCompletion:^(NSArray<MRModule *> *modules, NSError *error) {
		...
	}];
}];
```
