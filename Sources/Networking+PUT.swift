import Foundation

public extension Networking {
    /**
     PUT request to the specified path, using the provided parameters.
     - parameter path: The path for the PUT request.
     - parameter parameters: The parameters to be used, they will be serialized using the ParameterType, by default this is JSON.
     - parameter completion: A closure that gets called when the PUT request is completed, it contains a `JSON` object and a `NSError`.
     - returns: The request identifier.
     */
    public func PUT(path: String, parameterType: ParameterType = .JSON, parameters: AnyObject? = nil, completion: (JSON: AnyObject?, error: NSError?) -> ()) -> String  {
        let requestID = self.request(.PUT, path: path, parameterType: parameterType, parameters: parameters, parts: nil, responseType: .JSON) { JSON, headers, error in
            completion(JSON: JSON, error: error)
        }

        return requestID
    }

    /**
     PUT request to the specified path, using the provided parameters.
     - parameter path: The path for the PUT request.
     - parameter parameters: The parameters to be used, they will be serialized using the ParameterType, by default this is JSON.
     - parameter completion: A closure that gets called when the PUT request is completed, it contains a `JSON` object and a `NSError`.
     - returns: The request identifier.
     */
    public func PUT(path: String, parameterType: ParameterType = .JSON, parameters: AnyObject? = nil, completion: (JSON: AnyObject?, headers: [String : AnyObject], error: NSError?) -> ()) -> String  {
        let requestID = self.request(.PUT, path: path, parameterType: parameterType, parameters: parameters, parts: nil, responseType: .JSON, completion: completion)

        return requestID
    }

    /**
     Registers a fake PUT request for the specified path. After registering this, every PUT request to the path, will return the registered response.
     - parameter path: The path for the faked PUT request.
     - parameter response: An `AnyObject` that will be returned when a PUT request is made to the specified path.
     - parameter statusCode: By default it's 200, if you provide any status code that is between 200 and 299 the response object will be returned, otherwise we will return an error containig the provided status code.
     */
    public func fakePUT(path: String, response: AnyObject?, statusCode: Int = 200) {
        self.fake(.PUT, path: path, response: response, statusCode: statusCode)
    }

    /**
     Registers a fake PUT request to the specified path using the contents of a file. After registering this, every PUT request to the path, will return the contents of the registered file.
     - parameter path: The path for the faked PUT request.
     - parameter fileName: The name of the file, whose contents will be registered as a reponse.
     - parameter bundle: The NSBundle where the file is located.
     */
    public func fakePUT(path: String, fileName: String, bundle: NSBundle = NSBundle.mainBundle()) {
        self.fake(.PUT, path: path, fileName: fileName, bundle: bundle)
    }

    /**
     Cancels the PUT request for the specified path. This causes the request to complete with error code -999.
     - parameter path: The path for the cancelled PUT request.
     - parameter completion: A closure that gets called when the cancellation is completed.
     */
    public func cancelPUT(path: String, completion: (Void -> Void)? = nil) {
        let url = self.urlForPath(path)
        self.cancelRequest(.Data, requestType: .PUT, url: url, completion: completion)
    }
}
