class UrlsController < FassetsCore::AssetsController
  def show
    redirect_to @content.url
  end
  def content_model
    return Url
  end
end

