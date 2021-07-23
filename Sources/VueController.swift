import Vapor

public struct VueController: RouteCollection {
    
    private let path: [PathComponent]
    private let plugin: VuePlugin
    
    /**
     - Parameters:
        - path: Route path prefix.
        - distDir: Directory of Vue dist.
        - index: File name of index. Default is **index.html**.
        - jsDir: Relative directory of `javascript` files. Default is **js**.
        - cssDir: Relative directory of `css` files. Default is **css**.
        - imgDir: Relative directory of `image` files. Default is **image**.
     */
    public init(_ path: PathComponent..., distDir: String, index: String = "index.html", jsDir: String = "js", cssDir: String = "css", imgDir: String = "img") {
        self.path = path
        self.plugin = .init(distDir, index, jsDir, cssDir, imgDir)
    }
    
    public func boot(routes: RoutesBuilder) throws {
        let routes = routes.grouped(self.path)
        
        routes.get(use: handler(_:))
        routes.get("**", use: handler(_:))
    }
    
    func handler(_ req: Request) -> EventLoopFuture<Response> {
        let paths: [String] = req.parameters.getCatchall()
        
        if self.plugin.isIndex(paths.first ?? "") || paths.count == 0 {
            let index = req.fileio.streamFile(at: self.plugin.index)
            return req.eventLoop.makeSucceededFuture(index)
        }
        
        var path: String = self.plugin.path(paths)
        var isDir: ObjCBool = false
        
        if !FileManager.default.fileExists(atPath: path, isDirectory: &isDir) {
            if self.plugin.isJS(paths.first) || self.plugin.isCSS(paths.first) || self.plugin.isImg(paths.first) {
                return req.eventLoop.makeFailedFuture(Abort(.notFound))
            }
            
            path = self.plugin.index
        }
        
        let file = req.fileio.streamFile(at: path)
        
        return req.eventLoop.makeSucceededFuture(file)
    }
}
