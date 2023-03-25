# plister

An alternative to PlistBuddy written in Swift:

```
$ plister
USAGE: plister <input> --key <key> [--value <value>] [--output <output>] [--mode <mode>]

ARGUMENTS:
  <input>                 filename

OPTIONS:
  --key <key>
  --value <value>
  --output <output>
  --mode <mode>           Set the command. Allowed values: Print, Clear, Set, Copy, Delete (default: print)
  -h, --help              Show help information.
```



## Build
`swift build --configuration release`

A binary will appear in `.build/release/`.

It depends on [ArgumentParser](https://github.com/apple/swift-argument-parser), which it will automatically download when building.
