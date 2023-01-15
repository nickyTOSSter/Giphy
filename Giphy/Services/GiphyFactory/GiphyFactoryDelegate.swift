protocol GiphyFactoryDelegate: AnyObject {
    func didRecieveNextGiphy(_ giphy: GiphyModel)
    func didReciveError(_ error: GiphyError)
}
