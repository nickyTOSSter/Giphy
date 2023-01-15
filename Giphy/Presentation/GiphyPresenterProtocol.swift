import UIKit

protocol GiphyPresenterProtocol: AnyObject {
    init(giphyFactory: GiphyFactoryProtocol)

    func restart()
    func fetchNextGiphy()
    func saveGif(_ image: UIImage?)
    func numberOfShownGifs() -> Int
    func numberOfLikedGifs() -> Int
    func gifDisplayLimitHasBeenReached() -> Bool
}
