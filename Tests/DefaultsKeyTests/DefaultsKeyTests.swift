import XCTest
import DefaultsKey

private struct AppVersion: Codable {
    var versionString: String
}

private extension DefaultsKey {
    static var firstLaunchedAt: DefaultsKey<Date?> {
        return DefaultsKey<Date?>(key: "first_launched_at", defaultValue: nil)
    }

    static var latestLaunchedAt: DefaultsKey<Date?> {
        return DefaultsKey<Date?>(key: "latest_launched_at", defaultValue: nil)
    }

    static var shouldShowAppRatingDialog: DefaultsKey<Bool> {
        return DefaultsKey<Bool>(key: "should_show_app_rating_dialog", defaultValue: true)
    }

    static var appVersionHistory: DefaultsKey<[AppVersion]> {
        return DefaultsKey<[AppVersion]>(key: "version_history", defaultValue: [])
    }
}

final class DefaultsKeyTests: XCTestCase {
    private let suiteName = "DefaultsKeyTests"
    private var userDefaults: UserDefaults!

    override func setUp() {
        super.setUp()
        userDefaults = UserDefaults(suiteName: suiteName)!
    }
    
    override func tearDown() {
        super.tearDown()
        userDefaults.removePersistentDomain(forName: suiteName)
    }

    func testSuccessSetAndGetValue() {
        let date = Date(timeIntervalSince1970: 0)
        let appVersionHistory: [AppVersion] = [.init(versionString: "1.0.0"), .init(versionString: "1.0.1")]
        userDefaults.set(value: date, forKey: .firstLaunchedAt)
        userDefaults.set(value: nil, forKey: .latestLaunchedAt)
        userDefaults.set(value: false, forKey: .shouldShowAppRatingDialog)
        userDefaults.set(value: appVersionHistory, forKey: .appVersionHistory)

        XCTAssertEqual(date, userDefaults.value(forKey: .firstLaunchedAt))
        XCTAssertNil(userDefaults.value(forKey: .latestLaunchedAt))
        XCTAssertFalse(userDefaults.value(forKey: .shouldShowAppRatingDialog))
        XCTAssertEqual(appVersionHistory.count, userDefaults.value(forKey: .appVersionHistory).count)
    }

    func testSuccessGetDefaultValue() {
        XCTAssertNil(userDefaults.value(forKey: .firstLaunchedAt))
        XCTAssertNil(userDefaults.value(forKey: .latestLaunchedAt))
        XCTAssertTrue(userDefaults.value(forKey: .shouldShowAppRatingDialog))
        XCTAssertEqual(0, userDefaults.value(forKey: .appVersionHistory).count)
    }

    static var allTests = [
        ("testSuccessSetAndGetValue", testSuccessSetAndGetValue),
        ("testSuccessGetDefaultValue", testSuccessGetDefaultValue),
    ]
}
