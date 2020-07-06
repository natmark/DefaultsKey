<p align="left">
<a href="https://github.com/natmark/DefaultsKey/actions">
<img src="https://github.com/natmark/DefaultsKey/workflows/Swift/badge.svg?branch=master"
alt="Build Status">
</a>
<a href="https://cocoapods.org/pods/DefaultsKey">
<img src="https://img.shields.io/cocoapods/v/DefaultsKey.svg?style=flat"
alt="Pods Version">
</a>
</p>

# DefaultsKey

DefaultsKey allows you to specify the type and defaultValue for UserDefaults.

## Usage

```Swift
import DefaultsKey

extension DefaultsKey {
    static var firstLaunchedVersion: DefaultsKey<String?> {
        return DefaultsKey<String?>(key: "first_launched_version", defaultValue: nil)
    }

    static var shouldShowAppRatingDialog: DefaultsKey<Bool> {
        return DefaultsKey<Bool>(key: "should_show_app_rating_dialog", defaultValue: true)
    }

    static var appVersionHistory: DefaultsKey<[AppVersion]> {
        return DefaultsKey<[AppVersion]>(key: "version_history", defaultValue: [])
    }
}

struct AppVersion: Codable {
    var versionString: String
}

// Set value using DefaultsKey
UserDefaults.standard.set(value: "1.0.0", forKey: .firstLaunchedVersion)
UserDefaults.standard.set(value: [AppVersion(versionString: "1.0.0")], forKey: .appVersionHistory) // You can use Codable value

// Get value using DefaultsKey
let firstLaunchedAt = UserDefaults.standard.value(forKey: .firstLaunchedVersion)
print(firstLaunchedAt) // 1.0.0
let shouldShowAppRatingDialog = UserDefaults.standard.value(forKey: .shouldShowAppRatingDialog)
print(shouldShowAppRatingDialog) // true
let appVersionHistory = UserDefaults.standard.value(forKey: .appVersionHistory)
print(appVersionHistory) // [AppVersion(versionString: "1.0.0")]
```


