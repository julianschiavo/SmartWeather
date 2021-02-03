//
// WeatherModel.swift
//
// This file was automatically generated and should not be edited.
//

import CoreML


/// Model Prediction Input Type
@available(macOS 10.13, iOS 11.0, tvOS 11.0, watchOS 4.0, *)
class WeatherModelInput : MLFeatureProvider {

    /// Month as double value
    var Month: Double

    /// Day as double value
    var Day: Double

    /// Day Before Temperature as double value
    var Day_Before_Temperature: Double

    /// Day Before Day Before Temperature as double value
    var Day_Before_Day_Before_Temperature: Double

    var featureNames: Set<String> {
        get {
            return ["Month", "Day", "Day Before Temperature", "Day Before Day Before Temperature"]
        }
    }
    
    func featureValue(for featureName: String) -> MLFeatureValue? {
        if (featureName == "Month") {
            return MLFeatureValue(double: Month)
        }
        if (featureName == "Day") {
            return MLFeatureValue(double: Day)
        }
        if (featureName == "Day Before Temperature") {
            return MLFeatureValue(double: Day_Before_Temperature)
        }
        if (featureName == "Day Before Day Before Temperature") {
            return MLFeatureValue(double: Day_Before_Day_Before_Temperature)
        }
        return nil
    }
    
    init(Month: Double, Day: Double, Day_Before_Temperature: Double, Day_Before_Day_Before_Temperature: Double) {
        self.Month = Month
        self.Day = Day
        self.Day_Before_Temperature = Day_Before_Temperature
        self.Day_Before_Day_Before_Temperature = Day_Before_Day_Before_Temperature
    }
}


/// Model Prediction Output Type
@available(macOS 10.13, iOS 11.0, tvOS 11.0, watchOS 4.0, *)
class WeatherModelOutput : MLFeatureProvider {

    /// Source provided by CoreML

    private let provider : MLFeatureProvider


    /// Temperature as double value
    lazy var Temperature: Double = {
        [unowned self] in return self.provider.featureValue(for: "Temperature")!.doubleValue
    }()

    var featureNames: Set<String> {
        return self.provider.featureNames
    }
    
    func featureValue(for featureName: String) -> MLFeatureValue? {
        return self.provider.featureValue(for: featureName)
    }

    init(Temperature: Double) {
        self.provider = try! MLDictionaryFeatureProvider(dictionary: ["Temperature" : MLFeatureValue(double: Temperature)])
    }

    init(features: MLFeatureProvider) {
        self.provider = features
    }
}


/// Class for model loading and prediction
@available(macOS 10.13, iOS 11.0, tvOS 11.0, watchOS 4.0, *)
class WeatherModel {
    let model: MLModel

    /// URL of model assuming it was installed in the same bundle as this class
    class var urlOfModelInThisBundle : URL {
        Bundle.module.url(forResource: "WeatherModel", withExtension: "mlmodelc")!
    }

    /**
        Construct WeatherModel instance with an existing MLModel object.

        Usually the application does not use this initializer unless it makes a subclass of WeatherModel.
        Such application may want to use `MLModel(contentsOfURL:configuration:)` and `WeatherModel.urlOfModelInThisBundle` to create a MLModel object to pass-in.

        - parameters:
          - model: MLModel object
    */
    init(model: MLModel) {
        self.model = model
    }

    /**
        Construct WeatherModel instance by automatically loading the model from the app's bundle.
    */
    @available(*, deprecated, message: "Use init(configuration:) instead and handle errors appropriately.")
    convenience init() {
        try! self.init(contentsOf: type(of:self).urlOfModelInThisBundle)
    }

    /**
        Construct a model with configuration

        - parameters:
           - configuration: the desired model configuration

        - throws: an NSError object that describes the problem
    */
    @available(macOS 10.14, iOS 12.0, tvOS 12.0, watchOS 5.0, *)
    convenience init(configuration: MLModelConfiguration) throws {
        try self.init(contentsOf: type(of:self).urlOfModelInThisBundle, configuration: configuration)
    }

    /**
        Construct WeatherModel instance with explicit path to mlmodelc file
        - parameters:
           - modelURL: the file url of the model

        - throws: an NSError object that describes the problem
    */
    convenience init(contentsOf modelURL: URL) throws {
        try self.init(model: MLModel(contentsOf: modelURL))
    }

    /**
        Construct a model with URL of the .mlmodelc directory and configuration

        - parameters:
           - modelURL: the file url of the model
           - configuration: the desired model configuration

        - throws: an NSError object that describes the problem
    */
    @available(macOS 10.14, iOS 12.0, tvOS 12.0, watchOS 5.0, *)
    convenience init(contentsOf modelURL: URL, configuration: MLModelConfiguration) throws {
        try self.init(model: MLModel(contentsOf: modelURL, configuration: configuration))
    }

    /**
        Construct WeatherModel instance asynchronously with optional configuration.

        Model loading may take time when the model content is not immediately available (e.g. encrypted model). Use this factory method especially when the caller is on the main thread.

        - parameters:
          - configuration: the desired model configuration
          - handler: the completion handler to be called when the model loading completes successfully or unsuccessfully
    */
    @available(macOS 11.0, iOS 14.0, tvOS 14.0, watchOS 7.0, *)
    class func load(configuration: MLModelConfiguration = MLModelConfiguration(), completionHandler handler: @escaping (Swift.Result<WeatherModel, Error>) -> Void) {
        return self.load(contentsOf: self.urlOfModelInThisBundle, configuration: configuration, completionHandler: handler)
    }

    /**
        Construct WeatherModel instance asynchronously with URL of the .mlmodelc directory with optional configuration.

        Model loading may take time when the model content is not immediately available (e.g. encrypted model). Use this factory method especially when the caller is on the main thread.

        - parameters:
          - modelURL: the URL to the model
          - configuration: the desired model configuration
          - handler: the completion handler to be called when the model loading completes successfully or unsuccessfully
    */
    @available(macOS 11.0, iOS 14.0, tvOS 14.0, watchOS 7.0, *)
    class func load(contentsOf modelURL: URL, configuration: MLModelConfiguration = MLModelConfiguration(), completionHandler handler: @escaping (Swift.Result<WeatherModel, Error>) -> Void) {
        MLModel.__loadContents(of: modelURL, configuration: configuration) { (model, error) in
            if let error = error {
                handler(.failure(error))
            } else if let model = model {
                handler(.success(WeatherModel(model: model)))
            } else {
                fatalError("SPI failure: -[MLModel loadContentsOfURL:configuration::completionHandler:] vends nil for both model and error.")
            }
        }
    }

    /**
        Make a prediction using the structured interface

        - parameters:
           - input: the input to the prediction as WeatherModelInput

        - throws: an NSError object that describes the problem

        - returns: the result of the prediction as WeatherModelOutput
    */
    func prediction(input: WeatherModelInput) throws -> WeatherModelOutput {
        return try self.prediction(input: input, options: MLPredictionOptions())
    }

    /**
        Make a prediction using the structured interface

        - parameters:
           - input: the input to the prediction as WeatherModelInput
           - options: prediction options 

        - throws: an NSError object that describes the problem

        - returns: the result of the prediction as WeatherModelOutput
    */
    func prediction(input: WeatherModelInput, options: MLPredictionOptions) throws -> WeatherModelOutput {
        let outFeatures = try model.prediction(from: input, options:options)
        return WeatherModelOutput(features: outFeatures)
    }

    /**
        Make a prediction using the convenience interface

        - parameters:
            - Month as double value
            - Day as double value
            - Day_Before_Temperature as double value
            - Day_Before_Day_Before_Temperature as double value

        - throws: an NSError object that describes the problem

        - returns: the result of the prediction as WeatherModelOutput
    */
    func prediction(Month: Double, Day: Double, Day_Before_Temperature: Double, Day_Before_Day_Before_Temperature: Double) throws -> WeatherModelOutput {
        let input_ = WeatherModelInput(Month: Month, Day: Day, Day_Before_Temperature: Day_Before_Temperature, Day_Before_Day_Before_Temperature: Day_Before_Day_Before_Temperature)
        return try self.prediction(input: input_)
    }

    /**
        Make a batch prediction using the structured interface

        - parameters:
           - inputs: the inputs to the prediction as [WeatherModelInput]
           - options: prediction options 

        - throws: an NSError object that describes the problem

        - returns: the result of the prediction as [WeatherModelOutput]
    */
    @available(macOS 10.14, iOS 12.0, tvOS 12.0, watchOS 5.0, *)
    func predictions(inputs: [WeatherModelInput], options: MLPredictionOptions = MLPredictionOptions()) throws -> [WeatherModelOutput] {
        let batchIn = MLArrayBatchProvider(array: inputs)
        let batchOut = try model.predictions(from: batchIn, options: options)
        var results : [WeatherModelOutput] = []
        results.reserveCapacity(inputs.count)
        for i in 0..<batchOut.count {
            let outProvider = batchOut.features(at: i)
            let result =  WeatherModelOutput(features: outProvider)
            results.append(result)
        }
        return results
    }
}
