import ArgumentParser

struct SmartWeather: ParsableCommand {
    static let configuration = CommandConfiguration(
        abstract: "A command-line tool to predict the weather in Hong Kong",
        subcommands: [Predict.self])
    
    init() { }
}

SmartWeather.main()
