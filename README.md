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
modules.initSDK(apiKey: <API-KEY>, clientUserId: <YOUR-USER-ID>) { (user, error) in
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
[modules initSDKWithApiKey:<API-KEY> clientUserId:<YOUR-USER-ID> completion:^(MRUser *user, NSError *error) {
	...
	[modules getModulesWithCompletion:^(NSArray<MRModule *> *modules, NSError *error) {
		...
	}];
}];
```