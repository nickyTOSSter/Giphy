protocol GiphyFactoryProtocol {
    var delegate: GiphyFactoryDelegate? { get set }
    init(urlSession: GiphyURLSessionProtocol, mapper: GiphyModelMapperProtocol)
    func requestNextGiphy()
}
