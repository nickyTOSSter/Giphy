import UIKit

final class GiphyViewController: UIViewController {
    @IBOutlet weak var headerLabel: UILabel!
    @IBOutlet weak var counterLabel: UILabel!
    @IBOutlet weak var giphyImageView: UIImageView!
    @IBOutlet weak var giphyActivityIndicatorView: UIActivityIndicatorView!
    @IBOutlet weak var dislikeButton: UIButton!
    @IBOutlet weak var likeButton: UIButton!
     
    private let ypFont = "YSDisplay-Medium"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.restart()
    }
        
    @IBAction func onNoButtonTapped() {
        if presenter.gifDisplayLimitHasBeenReached() {
            showEndOfGiphy()
        } else {
            presenter.fetchNextGiphy()
        }
    }
    
    @IBAction func onYesButtonTapped() {
        if presenter.gifDisplayLimitHasBeenReached() {
            showEndOfGiphy()
        } else {
            presenter.saveGif(giphyImageView.image)
            presenter.fetchNextGiphy()
        }
    }
    
    private lazy var presenter: GiphyPresenterProtocol = {
        let presenter = GiphyPresenter()
        presenter.viewController = self
        return presenter
    }()
}

// MARK: - Приватные методы
private extension GiphyViewController {
    func customizeFonts() {
        headerLabel.font = UIFont(name: ypFont, size: 20)
        counterLabel.font = UIFont(name: ypFont, size: 20)
        dislikeButton.titleLabel?.font = UIFont(name: ypFont, size: 23)
        likeButton.titleLabel?.font = UIFont(name: ypFont, size: 23)
    }
}

// MARK: - GiphyViewControllerProtocol
extension GiphyViewController: GiphyViewControllerProtocol {
    func showError() {
        let alert = UIAlertController(title: "Что-то пошло не так(", message: "не возможно загрузить данные", preferredStyle: .alert)
        let handler = UIAlertAction(title: "Попробовать еще раз", style: .default) { [weak self] _ in
            guard let self = self else {
                return
            }
            self.presenter.restart()
        }
        alert.addAction(handler)
        present(alert, animated: true, completion: nil)
    }
    
    func showEndOfGiphy() {
        let alert = UIAlertController(title: "Мемы закончились!", message: "Вам понравилось: \(presenter.numberOfLikedGifs())/10", preferredStyle: .alert)
        alert.view.accessibilityIdentifier = "endOfTheGame"
        alert.addAction(UIAlertAction(title: "Хочу посмотреть еще гифок", style: .default){ [weak self] _ in
            guard let self = self else {
                return
            }
            self.presenter.restart()
        })
        present(alert, animated: true, completion: nil)
    }
    
    func showGiphy(_ image: UIImage?) {
        giphyImageView.image = image
    }
    
    func updateCounterLabel() {
        counterLabel.text = "\(presenter.numberOfShownGifs())/10"
    }
    
    func showLoader() {
        giphyImageView.image = nil
        giphyActivityIndicatorView.isHidden = false
        giphyActivityIndicatorView.startAnimating()
    }
    
    func hideHoaler() {
        giphyActivityIndicatorView.isHidden = true
        giphyActivityIndicatorView.stopAnimating()
    }
}
