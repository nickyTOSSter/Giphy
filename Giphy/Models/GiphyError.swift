import Foundation

enum GiphyError: Error {
    case wrongRequestURL
    case wrongDecoding
    case emptyData
    case wrongGifURL
}
