import UIKit

protocol GiphyViewControllerProtocol: AnyObject {
    func showError()
    func showGiphy(_ image: UIImage?)
    func showLoader()
    func hideHoaler()
    func updateCounterLabel()
}
