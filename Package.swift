// swift-tools-version:5.3
import PackageDescription

let CoreVersion = "3.4.20"
let CoreChecksum = "375167b7a44c2a67749a2e983eb50b6016160fa826c85c73c4bdf5c8f85d0118"

let VideoVersion = "2.0.4"
let VideoCheckSum = "57c0238995303336cb5022f0bfae5ec534394affe51b5bb4e625a63230a8264d"

let BioMatchVersion = "1.0.1"
let BioMatchCheckSum = "adec8e978ab4126b92cad9d3b2eaa5994e88c0d3ead7ac74e21060fe106999d7"

let package = Package(
    name: "AmaniRepo",
    defaultLocalization: "en",
    platforms: [
        .iOS(.v13)
    ],
    products: [
        .library(
            name: "AmaniSDK",
            targets: ["AmaniSDKBundle"]
        ),
        .library(
            name:"AmaniVideoSDK",
            targets: ["AmaniVideoBundle"]
        ),
        .library(
            name: "AmaniBioMatch",
            targets: ["AmaniBioMatchBundle"]
        )
    ],
    dependencies: [
        .package(
            name: "OpenSSL",
            url: "https://github.com/krzyzanowskim/OpenSSL.git",
            .upToNextMinor(from: "1.1.2300")
        ),
        .package(
            name: "SocketIO",
            url:    "https://github.com/socketio/socket.io-client-swift.git",
            .upToNextMinor(from: "16.1.0")
        ),
        .package(
            name:   "WebRTC",
            url: "https://github.com/stasel/WebRTC.git",
            .upToNextMinor(from: "127.0.0")
        ),
    ],
    targets: [
        .target(
            name: "AmaniSDKBundle",
            dependencies: [
                    "AmaniSDK",
                    "OpenSSL"
                ],
            linkerSettings:[
              .linkedFramework("CryptoKit"),
              .linkedFramework("CoreNFC"),
              .linkedFramework("CryptoTokenKit"),
            ]
        ),
        .binaryTarget(
            name: "AmaniSDK",
            url: "https://github.com/AmaniTechnologiesLtd/Public-IOS-SDK/blob/main/Carthage/AmaniSDK/v\(CoreVersion)/AmaniSDK.xcframework.zip?raw=true",
            checksum: "\(CoreChecksum)"
        ),  
        .binaryTarget(
          name: "AmaniBioMatch",
          url: "https://github.com/AmaniTechnologiesLtd/Public-IOS-SDK/blob/main/Carthage/AmaniBioMatch/v\(BioMatchVersion)/AmaniBioMatch.xcframework.zip?raw=true",
          checksum: "\(BioMatchCheckSum)"
        ),
        .target(
          name: "AmaniBioMatchBundle",
          dependencies: [
            "AmaniBioMatch"
          ]
        ),
        .binaryTarget(
            name: "AmaniVideoSDK",
            url: "https://github.com/AmaniTechnologiesLtd/Public-IOS-SDK/blob/main/Carthage/AmaniVideoSDK/\(VideoVersion)/AmaniVideoSDK.xcframework.zip?raw=true",
            checksum: "\(VideoCheckSum)"
        ),
        .target(
            name: "AmaniVideoBundle",
            dependencies: [
                    "AmaniVideoSDK",
                    "SocketIO",
                    "WebRTC"
                ]
        ), 
	
    ]
)

