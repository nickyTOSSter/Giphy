import Foundation

struct GiphyAPIModel: Decodable {
    let data: Data?
}

extension GiphyAPIModel {
    struct Data: Decodable {
        let id: String?
        let images: Images?
    }
}

extension GiphyAPIModel.Data {
    struct Images: Decodable {
        let preview_gif: PreviewGif?
    }
}

extension GiphyAPIModel.Data.Images {
    struct PreviewGif: Decodable {
        let url: URL?
    }
}
