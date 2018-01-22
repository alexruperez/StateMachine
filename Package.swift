import PackageDescription

let package = Package(
  name: "StateMachine",
  products: [
    .library(name: "StateMachine", targets: ["StateMachine"]),
  ],
  dependencies : [],
  exclude: ["UIKit", "Tests", "docs", "Dispenser"],
  targets: [
    .target(name: "StateMachine", dependencies: [])
  ]
)
