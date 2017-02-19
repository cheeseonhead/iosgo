//
// Created by Jeffrey Wu on 2017-02-19.
// Copyright (c) 2017 Cheeseonhead. All rights reserved.
//

import Foundation

class OGSDiskManager
{
    static var docPath: String = {
        var paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        return paths[0]
    }()

    func absoluteFileName(_ fileName: String) -> String
    {
        return type(of: self).docPath.appending(fileName)
    }

    func saveData(_ data: Any, objectName: String)
    {
        var dataPath = absoluteFileName(objectName)
        var objectData = NSArray.init(object: data)

        NSKeyedArchiver.archiveRootObject(objectData, toFile: dataPath)
    }
}
