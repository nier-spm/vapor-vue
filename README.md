# Vapor Vue

Vapor extension for [Vue CLI](https://cli.vuejs.org/)

## Features

- [x] VueController for Vue project

## Installation

### Swift Package Manager

```swift
dependencies: [
    .package(url: "https://github.com/nier-spm/vapor-vue.git", from: "0.0.1")
]
```

## Usage

```swift
// Package.swift
targets: [
    .target(
        name: "App",
        dependencies: [
            .product(name: "VaporVue", package: "vapor-vue"),
            ...
        ],
    }
],
```

## Import

```swift
import VaporVue
```

### Register Vue router

```swift
// routes.swift
let distDir = "{{your_vue_dist_directory}}"
let controller: VueController = VueController("vue", distDir: distDir)

try app.register(controller)
```
