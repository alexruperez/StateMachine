import PackageDescription

let package = Package(
  name: "StateMachine",
  products: [
    .library(name: "StateMachine", targets: ["StateMachine"]),
  ],
  dependencies : [],
  exclude: ["StateMachineTests", "docs"],
  targets: [
    .target(name: "StateMachine", dependencies: [])
  ]
)
