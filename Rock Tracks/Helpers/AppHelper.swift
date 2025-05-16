//
//  AppHelper.swift
//  Rock Tracks
//
//  Created by Yogesh Bharate on 15/05/25.
//

import Foundation

struct AppHelper {
    
    static var isUITestCases: Bool {
        return CommandLine.arguments.contains("--ui-testing")
    }
    
    static func load(filename: String, type: String = "json") -> Data {
        guard let url = Bundle.main.url(forResource: filename,
                                        withExtension: type) else {
            fatalError("Failed to locate \(filename) in bundle.")
        }
        guard let data = try? Data(contentsOf: url) else {
            fatalError("Failed to load \(filename) from bundle.")
        }
        return data
    }
}
