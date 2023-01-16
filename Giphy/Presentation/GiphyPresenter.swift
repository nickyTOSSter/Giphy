import Foundation
import UIKit
import Photos

final class GiphyPresenter: GiphyPresenterProtocol {
    private var giphyFactory: GiphyFactoryProtocol
    private var showdGifCounter = 0
    private var likedGifCounter = 0

    weak var viewController: GiphyViewControllerProtocol?
    
    // MARK: - GiphyPresenterProtocol
    init(giphyFactory: GiphyFactoryProtocol = GiphyFactory()) {
        self.giphyFactory = giphyFactory
        self.giphyFactory.delegate = self
    }
    
    func restart() {
        showdGifCounter = 0
        likedGifCounter = 0
        fetchNextGiphy()
    }
    
    func fetchNextGiphy() {
        viewController?.showLoader()
        giphyFactory.requestNextGiphy()
    }
    
    func saveGif(_ image: UIImage?) {
        guard let data = image?.pngData() else {
            return
        }
        
        PHPhotoLibrary.shared().performChanges({
            let request = PHAssetCreationRequest.forAsset()
            request.addResource(with: .photo, data: data, options: nil)
        })
        likedGifCounter += 1
    }
    
    func numberOfShownGifs() -> Int {
        return showdGifCounter
    }
    
    func numberOfLikedGifs() -> Int {
        return likedGifCounter
    }
    
    func gifDisplayLimitHasBeenReached() -> Bool {
        return showdGifCounter == 10
    }
}

// MARK: - GiphyFactoryDelegate

extension GiphyPresenter: GiphyFactoryDelegate {
    func didRecieveNextGiphy(_ giphy: GiphyModel) {
        let image = UIImage.gif(url: giphy.url)
        DispatchQueue.main.async { [weak self] in
            guard let self = self else {
                return
            }
            self.showdGifCounter += 1
            self.viewController?.updateCounterLabel()
            self.viewController?.hideHoaler()
            self.viewController?.showGiphy(image)
        }
    }
    
    func didReciveError(_ error: GiphyError) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else {
                return
            }
            self.viewController?.hideHoaler()
            self.viewController?.showError()
        }
    }
}
