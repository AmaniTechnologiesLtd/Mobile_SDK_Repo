// swift-tools-version:5.3
import PackageDescription

let CoreVersion = "3.4.19"
let CoreChecksum = "59fb82c50e0b4e3963d8ea5b91ba61361d70bcdd43221ee5af98d31ff5976e20"

let VideoVersion = "2.0.3"
let VideoCheckSum = "8dcf51f00f24e599feec1cb92e4e0631216494335a431debec1a6b597e3110ad"

let BioMatchVersion = "1.0.0"
let BioMatchCheckSum = "ecb2333a29a4a20d8a3ae2ee913620209d4d5fc53747ebe566c9a79637059bf4"

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

