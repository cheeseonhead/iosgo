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

    func getImage(fullUrl: String) -> Promise<UIImage> {

        return firstly { () -> Promise<Data> in
            guard let url = URL(string: fullUrl) else {
                throw ParseError.urlError(url: fullUrl)
            }
            var request = URLRequest(url: url)
            request.httpMethod = HTTPMethod.GET.rawValue

            return apiStore.send(request: request)
        }.map { data in
            guard let image = UIImage(data: data) else {
                throw ParseError.imageError(url: fullUrl)
            }

            return image
        }
    }
}
