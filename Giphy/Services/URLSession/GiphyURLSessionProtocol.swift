import Foundation

// Протокол сетевого слоя, через который будут загружаться гифки
// Через сетевой слой будут загружаться гифки
//
// Документация: https://developers.giphy.com/explorer/?
// Токен: 3kc6OFgsZGKURypdRNAiXhK2r5gnQaVs
// Ресурс: Public API
// Endpoint: Random
// Пример запроса: https://api.giphy.com/v1/gifs/random?api_key=3kc6OFgsZGKURypdRNAiXhK2r5gnQaVs&tag=&rating=g

protocol GiphyURLSessionProtocol {
    init(urlSession: URLSession)
    func fetchGiphy(completion: ((Result<GiphyAPIModel, GiphyError>) -> Void)?)
}

