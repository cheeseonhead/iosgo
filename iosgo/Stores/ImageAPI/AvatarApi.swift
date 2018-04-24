//
//  ImageApi.swift
//  iosgo
//
//  Created by Cheese Onhead on 2018-04-23.
//  Copyright © 2018 Cheeseonhead. All rights reserved.
//

import Foundation
import PromiseKit

class AvatarApi {
    private var apiStore: OGSApiStore

    init(apiStore: OGSApiStore) {
        self.apiStore = apiStore
    }

    enum ServerType {
        case gravatar
        case ogs
    }

    func getImage(fullUrl: String, size: Int) -> Promise<UIImage> {

        return firstly { () -> Promise<Data> in
            guard let url = URL(string: fullUrl) else {
                throw ParseError.urlError(url: fullUrl)
            }
            let resizedURL = newURL(oldURL: url, size: size)
            var request = URLRequest(url: resizedURL)
            request.httpMethod = HTTPMethod.GET.rawValue

            return apiStore.send(request: request)
        }.map { data in
            guard let image = UIImage(data: data) else {
                throw ParseError.imageError(url: fullUrl)
            }

            return image
        }
    }

    private func newURL(oldURL: URL, size: Int) -> URL {

        var components = URLComponents(url: oldURL, resolvingAgainstBaseURL: false)!

        let type = typeOfUrl(url: oldURL)

        switch type {
        case .gravatar:
            components.query = "s=\(size)&d=retro"
            return components.url!
        case .ogs:
            let newString = ogsUrl(oldURL: oldURL.absoluteString, size: size)
            return URL(string: newString)!
        }
    }

    private func typeOfUrl(url: URL) -> ServerType {
        if let host = url.host, host == "secure.gravatar.com" {
            return .gravatar
        } else {
            return .ogs
        }
    }

    private func ogsUrl(oldURL: String, size: Int) -> String {
        let cutPoint = oldURL.index(oldURL.endIndex, offsetBy: -6)
        let absString = oldURL.prefix(upTo: cutPoint)
        return absString.appending("\(size).png")
    }
}
