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

Initialize
```swift
let modules = MRModules()
modules.initSDK(apiKey: <API_KEY>, clientUserId: <USER_ID>) { (user, error) in
            ...
        }
```

Optionally, include language, country code and timezone.<br/>
Language: https://www.wikiwand.com/en/List_of_ISO_639-1_codes<br/>
Country Code: https://www.wikiwand.com/en/ISO_3166-1_alpha-2<br/>
Timezone: https://en.wikipedia.org/wiki/List_of_tz_database_time_zones
```swift
modules.initSDK(apiKey: <API_KEY>, clientUserId: <USER_ID>, langauge: "en", countryCode: "us", timezone: "America/Los_Angeles") { (user, error) in
            ...
        }
```

Get modules 
```swift
modules.getModules() { [weak self] (modules, error) in
            ...
        }
```

Note: initSDK(...) must finish before you can call getModules().

#### Objective-C

```objc
#import "MentorModules-Swift.h"
```

```objc
MRModules *modules = [MRModules new];
[modules initSDKWithApiKey:<API_KEY> clientUserId:<USER_ID> langauge:@"en" countryCode:@"us" timezone:@"America/Los_Angeles" completion:^(MRUser *user, NSError *error) {
	...
}];

...

[modules getModulesWithCompletion:^(NSArray<MRModule *> *modules, NSError *error) {
	...
}];
```
