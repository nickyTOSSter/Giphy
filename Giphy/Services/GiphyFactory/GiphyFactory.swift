final class GiphyFactory: GiphyFactoryProtocol {
    private let urlSession: GiphyURLSessionProtocol
    private let mapper: GiphyModelMapperProtocol
    
    weak var delegate: GiphyFactoryDelegate?
    
    // MARK: - GiphyFactoryProtocol
    init(
        urlSession: GiphyURLSessionProtocol = GiphyURLSession(),
        mapper: GiphyModelMapperProtocol = GiphyModelMapper()
    ) {
        self.urlSession = urlSession
        self.mapper = mapper
    }
    
    func requestNextGiphy() {
        urlSession.fetchGiphy { [weak self] result in
            switch result {
            case .success(let apiModel):
                if let model = self?.mapper.map(model: apiModel) {
                    self?.delegate?.didRecieveNextGiphy(model)
                } else {
                    self?.delegate?.didReciveError(.emptyData)
                }
                
            case .failure(let error):
                self?.delegate?.didReciveError(error)
            }
        }
    }
}
