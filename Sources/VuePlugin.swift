import Foundation

struct VuePlugin {
    
    private var _dist: String
    private var _index: String
    private var _javascript: String
    private var _css: String
    private var _image: String
    
    init(_ dist: String, _ index: String, _ javascript: String, _ css: String, _ image: String) {
        var distDir: String = dist.removingPercentEncoding ?? dist
        var indexDir: String = index.removingPercentEncoding ?? index
        var jsDir: String = javascript.removingPercentEncoding ?? javascript
        var cssDir: String = css.removingPercentEncoding ?? css
        var imgDir: String = image.removingPercentEncoding ?? image
        
        // dist
        while distDir.hasSuffix("/") {
            distDir = String(distDir.dropLast())
        }
        
        // index
        if indexDir.hasPrefix("./") {
            indexDir = String(indexDir.dropFirst(2))
        }
        
        // javascript
        if jsDir.hasPrefix("./") {
            jsDir = String(jsDir.dropFirst(2))
        }
        
        while jsDir.hasSuffix("/") {
            jsDir = String(jsDir.dropLast())
        }
        
        // css
        if cssDir.hasPrefix("./") {
            cssDir = String(cssDir.dropFirst(2))
        }
        
        while cssDir.hasSuffix("/") {
            cssDir = String(cssDir.dropLast())
        }
        
        // image
        if imgDir.hasPrefix("./") {
            imgDir = String(imgDir.dropFirst(2))
        }
        
        while imgDir.hasSuffix("/") {
            imgDir = String(imgDir.dropLast())
        }
        
        self._dist = distDir
        self._index = indexDir
        self._javascript = jsDir
        self._css = cssDir
        self._image = imgDir
    }
}

extension VuePlugin {
    
    func isIndex(_ path: String?) -> Bool {
        return path == self._index
    }

    func isJS(_ path: String?) -> Bool {
        return path == self._javascript
    }

    func isCSS(_ path: String?) -> Bool {
        return path == self._css
    }

    func isImg(_ path: String?) -> Bool {
        return path == self._image
    }
}

extension VuePlugin {

    var index: String {
        return self._index.hasPrefix("/") ? self._index : self._dist + "/" + self._index
    }
    
    func path(_ paths: [String]) -> String {
        return self._dist + "/" + paths.joined(separator: "/")
    }
}
