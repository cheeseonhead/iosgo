//
// Created by Jeffrey Wu on 2017-02-19.
// Copyright (c) 2017 Cheeseonhead. All rights reserved.
//

import Foundation

protocol OGSVersionedCoding: NSCoding
{
    static var DataName: String { get }
    static var DataVersion: Int { get }
}

class OGSDiskManager
{
    static let DataFileExtension = ".plist"

    enum DataKey: String
    {
        case version
        case payload
    }

    static var docPath: URL = {
        var paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        return URL.init(string: paths[0])!
    }()

    static func saveObject<PayloadClass: NSObject>(_ objectToStore: PayloadClass) -> Bool where PayloadClass: OGSVersionedCoding
    {
        return saveObject(objectToStore, message: "")
    }

    static func saveObject<PayloadClass: OGSVersionedCoding>(_ objectToStore: PayloadClass, message: String) -> Bool where PayloadClass: NSObject
    {
        var dataPath = absoluteFileName(type(of: objectToStore).DataName.appending(message))
        var objectData: [String: Any] = [
            stringFor(dataKey: .version): type(of: objectToStore).DataVersion,
            stringFor(dataKey: .payload): objectToStore,
        ]

        var success = NSKeyedArchiver.archiveRootObject(objectData, toFile: dataPath)
        return success
    }

    static func getData<PayloadClass: OGSVersionedCoding>(forClass payLoadClass: PayloadClass.Type) -> PayloadClass?
    {
        var dataPath = absoluteFileName(payLoadClass.DataName)

        do
        {
            guard let objectData = try NSKeyedUnarchiver.unarchiveObject(withFile: dataPath) as? [String: Any],
                let storedVersion = objectData[stringFor(dataKey: .version)] as? Int,
                let payload = objectData[stringFor(dataKey: .payload)] as? PayloadClass else
            {
                return nil
            }

            guard storedVersion == payLoadClass.DataVersion else
            {
                return nil
            }

            return payload
        }
        catch
        {
            return nil
        }
    }
}

// MARK: - Helpers
fileprivate extension OGSDiskManager
{
    static func absoluteFileName(_ fileName: String) -> String
    {
        return docPath.appendingPathComponent(fileName).absoluteString.appending(DataFileExtension)
    }

    static func stringFor(dataKey: DataKey) -> String
    {
        return dataKey.rawValue
    }
}
