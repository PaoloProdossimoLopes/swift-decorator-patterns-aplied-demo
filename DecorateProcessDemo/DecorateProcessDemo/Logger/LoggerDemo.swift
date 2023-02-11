import Domain

final class LoggerDemo: Logger {
    func log(event: LogEvent) {
        print("🚨 DEBUG:")
        print("\t Description: \(event.description)")
    }
}
