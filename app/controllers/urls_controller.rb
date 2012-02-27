class UrlsController < AssetsController
  def show
    redirect_to @content.url
  end
  def content_model
    return Url
  end
  def edit_box
    @content = Url.find(params[:id])
    render :template => 'assets/edit', :layout => false, :locals => {:in_fancybox => true}
  end
end

