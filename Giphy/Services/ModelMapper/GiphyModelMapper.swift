final class GiphyModelMapper: GiphyModelMapperProtocol {
    // MARK: - GiphyURLSessionProtocol

    func map(model: GiphyAPIModel) -> GiphyModel? {
        guard
            let id = model.data?.id,
            let url = model.data?.images?.preview_gif?.url
        else {
            return nil
        }

        return GiphyModel(id: id, url: url)
    }
}
