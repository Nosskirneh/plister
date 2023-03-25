import Foundation
import ArgumentParser

extension String: Error {}

enum Mode: String, ExpressibleByArgument, CaseIterable {
    case print = "Print"
    case clear = "Clear"
    case set = "Set"
    case copy = "Copy"
    case delete = "Delete"
}

struct Plister: ParsableCommand {
    @Argument(help: "filename")
    var input: String

    @Option(help: "Set the command. Allowed values: \(Mode.allValueStrings.joined(separator: ", "))")
    var mode: Mode = .print

    @Option var key: String
    @Option var value: String = ""
    @Option var output: String = ""

    mutating func run() throws {
        var plist = try loadDictionary()

        if (mode == .print) {
            guard let value = plist[key] else { throw "Key not found" }
            print(value)
            return
        } else if (mode == .set) {
            plist[key] = value
        } else if (mode == .delete) {
            plist[key] = nil
        }

        try storeDictionary(plist)
    }

    private func loadDictionary() throws -> [String:Any] {
        if (mode == .clear) {
            return [String: Any]()
        }

        let url = URL(fileURLWithPath: input)
        let data = try Data(contentsOf: url)

        guard let plist = try PropertyListSerialization.propertyList(from: data,
                                                                     format: nil) as? [String:Any] else {
            throw "Loading plist failed"
        }
        return plist
    }

    private func storeDictionary(_ plist: [String:Any]) throws {
        var outputFilename = input
        if (output != "") {
            outputFilename = output
        }
        let url = URL(fileURLWithPath: outputFilename)
        guard let plistData = try? PropertyListSerialization.data(fromPropertyList: plist,
                                                                  format: .xml,
                                                                  options: 0) else {
            throw "Serialization failed"
        }

        do {
            try plistData.write(to: url)
        }
        catch let error {
            throw "Writing failed: \(error.localizedDescription)"
        }
    }
}

Plister.main()
