import ArgumentParser
import CoreML
import Foundation

struct Predict: ParsableCommand {
    public static let configuration = CommandConfiguration(abstract: "Predict the temperature in Hong Kong.")
    
    @Option(name: .long, help: "The measurement to predict")
    private var measurement: Measurement = .temperature
    
    @Option(name: .shortAndLong, help: "The month of the date")
    private var month: Int
    
    @Option(name: .shortAndLong, help: "The day of the date")
    private var day: Int
    
    @Option(name: .long, help: "The temperature yesterday")
    private var yesterdayTemperature: Double
    
    @Option(name: .long, help: "The temperature the day before yesterday")
    private var dayBeforeYesterdayTemperature: Double
    
    func run() throws {
        let model = try WeatherModel(configuration: MLModelConfiguration())
        let prediction = try model.prediction(Month: Double(month), Day: Double(day), Day_Before_Temperature: yesterdayTemperature, Day_Before_Day_Before_Temperature: dayBeforeYesterdayTemperature)
        let temperature = prediction.Temperature.rounded(to: 1)
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .long
        
        let year = Calendar.current.component(.year, from: Date())
        let dateComponents = DateComponents(year: year, month: month, day: day)
        let date = Calendar.current.date(from: dateComponents) ?? Date()
        let formattedDate = dateFormatter.string(from: date)
        
        print("It's going to be \(temperature)°C on \(formattedDate).")
    }
}
