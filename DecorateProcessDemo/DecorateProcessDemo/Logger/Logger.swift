struct LogEvent {
    let description: String
}

protocol Logger {
    func log(event: LogEvent)
}
