import Testing
@testable import Financial

@Suite("UserDefaultsWrapper базовые тесты")
struct UserDefaultsWrapperTests {
    let testKey = UserKeys.presentViewed
    let wrapper = UserDefaultsWrapper.instance

    @Test("Сет и гет строки")
    func testSetAndGetString() async throws {
        let value = "TestValue123"
        wrapper.setValue(forKey: testKey, value: value)
        let fetched = wrapper.getString(testKey)
        #expect(fetched == value, "Значение должно сохраняться и извлекаться корректно")
    }
    
    @Test("Проверка установки значения по умолчанию через checkKey")
    func testCheckKeySetsDefault() async throws {
        let defaultValue = "DefaultTestValue"
        // Сначала удаляем значение, если оно есть
        UserDefaults.standard.removeObject(forKey: testKey.rawValue)
        wrapper.checkKey(forKey: testKey, defaultValue: defaultValue)
        let fetched = wrapper.getString(testKey)
        #expect(fetched == defaultValue, "checkKey должен выставлять дефолтное значение, если его не было")
    }
}
